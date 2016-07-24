require 'rails_helper'

describe 'Omniauth', type: :request do

  subject { page }
 
  describe 'thrue facebook' do
 
    context 'should' do
      let!(:oauth_user) { set_omniauth(:facebook) }
      
      before do
        login_with_omniauth(oauth_user.provider)
        fb_user_data(oauth_user)
      end

      it 'have right page content' do
        expect(page).to have_content('Successfully authenticated from Facebook account.')
      end
      it 'use FB as provider' do
        expect(oauth_user.provider).to eq 'facebook'
      end
      it 'user not to be nil' do
        expect(@user).not_to eq nil
      end
      it 'auth w right provider' do
        expect(@identity.provider).to eq oauth_user.provider
      end
      it 'auth w right uid' do
        expect(@identity.uid).to eq oauth_user.uid
      end
      it 'auth w right username' do
        expect(@user.username).to eq oauth_user.extra.raw_info.name
      end
      it 'auth w right temp email' do     
        expect(email_analyzer(@user.email)).to eq true
      end
    end
  end
end