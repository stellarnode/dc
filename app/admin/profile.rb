ActiveAdmin.register Profile do

	actions :all, except: [:new, :create, :destroy]

	permit_params :first_name, :last_name, :middle_name, :phone, :avatar, :avatar_cache, :remove_avatar
	
	belongs_to :user, optional: true

	menu parent: 'Users', priority: 1

	index do
		selectable_column
		id_column
		column 'Avatar' do |profile|
			profile.avatar? ? image_tag(profile.avatar, size: '30') : image_tag('man.png', size: '30')
		end
		column :user
		column :full_name
		column :phone
		column :created_at
		column :updated_at
		actions
	end

	show do
		attributes_table do
			row :id
			row :user
			row :full_name
			row :phone
			row('Avatar path') 	{ |profile| profile.avatar }
			row('Avatar') 			{ |profile| profile.avatar? ? 
														image_tag(profile.avatar, size: '50') : image_tag('man.png', size: '50') }
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors *f.object.errors
		f.inputs "#{resource.user.username} Profile Details", html: {multipart: true} do
			f.input :first_name
			f.input :middle_name
			f.input :last_name
			f.input :phone, as: :phone
			f.inputs 'Avatar' do
				f.input :avatar, hint: profile.avatar? ? image_tag(profile.avatar, size: '100') : image_tag('man.png', size: '100')
				f.hidden_field :avatar_cache
				f.input :remove_avatar, as: :boolean, label: 'Remove avatar' if profile.avatar?
			end
		end
		f.actions
	end

	preserve_default_filters!
	remove_filter :avatar

end
