ActiveAdmin.register ChatMessage do

	actions :all, except: [:new, :create]

	permit_params :message

	belongs_to :user, optional: true

	menu priority: 8

	index do
		selectable_column
		id_column
		column 'User' do |chat_message|		
			if chat_message.user
				link_to chat_message.user.username, admin_user_path(chat_message.user_id)
			else
				status_tag('User deleted', :warning)
			end
		end	
		column 'Message', :display_name
		column 	:created_at
		actions
	end

	show do
		attributes_table do
			row :id
			if resource.user
				row :user				
			else
				row('User deleted')
			end
			row :message
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors *f.object.errors
		f.inputs "Chat Message Details" do
			if resource.user
				li para strong "User: #{resource.user.username}"
			else
				li para strong 'User DELETED'
			end
			f.input :message
		end
		f.actions
	end

	preserve_default_filters!
	remove_filter :updated_at

end
