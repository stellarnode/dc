include Warden::Test::Helpers 

module RequestHelpers

Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

  def login(user)
    login_as user, scope: :user
  end
 
  def set_omniauth(service)
    OmniAuth.config.test_mode = true
 
    OmniAuth.config.mock_auth[service] = OmniAuth::AuthHash.new({
      provider: service.to_s,
      uid:      '1234'
    })
 
    case service
    when :facebook
      OmniAuth.config.add_mock(service,
        { info: {
            email: "#{service.to_s}_oauth_user@example.com",
            name: "John Doe",
            first_name: "John",
            last_name: "Doe"
            },
          extra: {
            raw_info: {
              name: "#{service.to_s}_oauth_user"
            }
          }
        }
      )
    when :twitter
      OmniAuth.config.add_mock(service,
        { info: {
            nickname: "#{service.to_s}_oauth_user"
          }
        }
      )
    end
 
    OmniAuth.config.mock_auth[service]
  end
 
  def login_with_omniauth(service)
    visit "/users/auth/#{service.to_s}"
  end

  def fb_user_data(oauth_user)
    @oauth_user = oauth_user
    @identity = Identity.where(:provider => @oauth_user.provider, :uid => @oauth_user.uid).first
    @user = User.where(:id => @identity.user).first
  end

  def email_analyzer(email)
    email =~ /\Adc@user/ ? true : false
  end
end