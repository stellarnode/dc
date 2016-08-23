ActiveAdmin.register Option do

	permit_params :poll_option, :poll_id
	
	menu priority: 9

end