ActiveAdmin.register Payment do

	permit_params :receiver, :formcomment, :short_dest, :quickpay_form, :targets, :payment_type, :sum, :label, 
								:comment, :successURL, :need_fio, :need_email, :need_phone, :need_address, :payment_id
	
	belongs_to :user, optional: true

	menu priority: 8

	preserve_default_filters!
	remove_filter :updated_at

end
