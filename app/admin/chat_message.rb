ActiveAdmin.register ChatMessage do

	permit_params :message

	belongs_to :user, optional: true

	menu priority: 8

end
