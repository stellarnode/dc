ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  includes :profile

  menu priority: 1

  scope :all, default: true
  scope :admins
  scope :users
  scope :moderators

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :profile
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
