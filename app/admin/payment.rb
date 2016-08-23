ActiveAdmin.register Payment do

	permit_params :receiver, :formcomment, :short_dest, :quickpay_form, :targets, :payment_type, :sum, :label, 
								:comment, :successURL, :need_fio, :need_email, :need_phone, :need_address, :payment_id
	menu priority: 8

end
