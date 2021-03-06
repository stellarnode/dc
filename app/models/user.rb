class User < ApplicationRecord

  TEMP_EMAIL_PREFIX = 'dc@user'
  TEMP_EMAIL_REGEX  = /\Adc@user/

  attr_accessor     :login

  after_create      :create_profile
  after_initialize  :add_role_to_user,  if: :new_record?
  has_one           :profile,           dependent: :destroy
  has_many          :posts,             dependent: :destroy
  has_many          :identities,        dependent: :destroy
  has_many          :emails,            dependent: :destroy
  has_many          :polls,             dependent: :destroy
  has_many          :chat_messages,     dependent: :nullify
  has_many          :votes,             dependent: :destroy
  has_many          :payments,          dependent: :destroy
  has_many          :comments,          dependent: :nullify

  #Use roles for user model
  rolify

  scope :admins,     -> { joins(:roles).where('roles.name = ?', 'admin').distinct }
  scope :users,      -> { joins(:roles).where('roles.name = ?', 'user').distinct }
  scope :moderators, -> { joins(:roles).where('roles.name = ?', 'moderator').distinct }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update
  
  validates :username, presence: true,
            length: { maximum: 20 },
            exclusion: { in: %w(admin superuser superadmin moderator) },
            format: { with: /\A[a-zA-Z0-9А-Яа-я_\s]+\z/ }, uniqueness: { case_sensitive: false }

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email #&& (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation! if user.respond_to?(:skip_confirmation)
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def create_profile
    Profile.create(user: self)
  end

  def add_role_to_user
    if self == User.first
      add_role 'admin'
    else
      add_role 'user'
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions. to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

end
