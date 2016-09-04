ActiveAdmin.register User do
  
  config.batch_actions = false

  permit_params :username, :email, :password, :password_confirmation

  includes :profile

  menu parent: 'Users', priority: 0

  scope :all, default: true
  scope :admins
  scope :users
  scope :moderators

  index do
    selectable_column
    id_column
    column 'Avatar' do |user|
      user.profile.avatar? ? image_tag(user.profile.avatar, size: '30') : image_tag('man.png', size: '30')
    end
    column :username
    column :email
    column :profile    
    column :created_at    
    column :current_sign_in_at
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors
    f.inputs 'User Details' do
      f.input :username
      f.input :email
      if ['new', 'create'].include? action_name or params[:full_edit] == 'true'
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

  filter :username
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  sidebar 'User Has', only: [:show, :edit] do
    para strong link_to "User's Profile", admin_profiles_path(q: { user_id_eq: resource.id })
    para strong link_to "User's Posts", admin_user_posts_path(resource)
    para strong link_to "User's Polls", admin_user_polls_path(resource)
    para strong link_to "User's Votes", admin_votes_path(q: { user_id_eq: resource.id })
    para strong link_to "User's Payments", admin_user_payments_path(resource)
    para strong link_to "User's E-mails", admin_user_emails_path(resource)
    para strong link_to "User's Comments", admin_user_comments_path(resource)
    para strong link_to "User's Chat Messages", admin_user_chat_messages_path(resource)
    para strong link_to "User's Roles", admin_user_roles_path(resource)
    para strong link_to "User's Identities", admin_user_identities_path(resource)
  end

  action_item :view, only: [:edit, :show] do
    link_to 'Full Edit', edit_admin_user_path(resource, full_edit: true)
  end

end
