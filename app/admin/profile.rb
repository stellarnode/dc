ActiveAdmin.register Profile do

	belongs_to :user, optional: true
	#navigation_menu :user

	permit_params :first_name, :last_name, :middle_name, :phone, :avatar

	menu priority: 4

	preserve_default_filters!
	remove_filter :avatar

end
