ActiveAdmin.register Payment do

	permit_params :receiver, :formcomment, :short_dest, :quickpay_form, :targets, :payment_type, :sum, :label, 
								:comment, :successURL, :need_fio, :need_email, :need_phone, :need_address, :payment_id
	
	belongs_to :user, optional: true

	menu priority: 8

	index do
		selectable_column
		id_column    
		column :user
		column :receiver
		column :formcomment
		column :short_dest
		column :sum
		column :created_at
		actions
	end

	show do
		attributes_table do
			row :user_id
			row :receiver
			row :formcomment
			row :short_dest
			row :quickpay_form
			row :targets
			row :payment_type
			row :sum
			row :label
			row :comment
			row :successURL
			row :need_fio
			row :need_email
			row :need_phone
			row :need_address
			row :created_at
			row :updated_at
		end
	end
		
	form do |f|
		f.semantic_errors *f.object.errors
		f.inputs "Chat Message Details" do
			li para strong "User: #{resource.user.username}" if resource.user
			f.input :receiver, label: 'Yandex wallet ID'
			f.input :formcomment, label: 'Project or crowd-funding objective'
			f.input :sum
			f.input :comment
			f.input :need_fio, label: "Require payer's name"
			f.input :need_email, label: "Require payer's email"
			f.input :need_phone, label: "Require payer's phone number"
			f.input :need_address, label: "Require payer's address"
		end
	f.actions
	end

	preserve_default_filters!
	remove_filter :quickpay_form, :targets, :payment_type, :label, :comment, :successURL, :need_fio,
								:need_email, :need_phone, :need_address, :updated_at

end
