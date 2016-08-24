ActiveAdmin.register Profile do

	menu parent: 'Users', priority: 1

	permit_params :first_name, :last_name, :middle_name, :phone, :avatar

	preserve_default_filters!
	remove_filter :avatar

end
