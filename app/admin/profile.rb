ActiveAdmin.register Profile do

	belongs_to :user, optional: true
	#navigation_menu :user

	preserve_default_filters!
	remove_filter :avatar

	menu priority: 4

end
