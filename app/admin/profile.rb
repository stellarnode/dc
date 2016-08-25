ActiveAdmin.register Profile do

	permit_params :first_name, :last_name, :middle_name, :phone, :avatar
	
	belongs_to :user, optional: true

	menu parent: 'Users', priority: 1

	index do
    selectable_column
    id_column
    column "Avatar" do |profile|
      profile.avatar? ? image_tag(profile.avatar, size: "30") : image_tag('man.png', size: "30")
    end
    column :user
    column :full_name
    column :phone
    column :created_at
    column :updated_at
    actions
  end

	preserve_default_filters!
	remove_filter :avatar

end
