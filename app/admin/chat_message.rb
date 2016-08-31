ActiveAdmin.register ChatMessage do

	actions :all, except: [:new, :create]

	permit_params :message

	belongs_to :user, optional: true

	menu priority: 8

	index do
		selectable_column
		id_column    
		column :user
		column 'Message', :display_name
		column 	:created_at
		actions
	end

	show do
		attributes_table do
			row :id
			row :user
			row :message
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors *f.object.errors
		f.inputs "Chat Message Details" do
			li para strong "User: #{resource.user.username}" if resource.user
			f.input :user unless resource.user
			f.input :message
		end
		f.actions
	end

	preserve_default_filters!
	remove_filter :updated_at

end
