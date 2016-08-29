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

	preserve_default_filters!
	remove_filter :quickpay_form, :targets, :payment_type, :label, :comment, :successURL, :need_fio,
    			 			:need_email, :need_phone, :need_address, :updated_at

end
