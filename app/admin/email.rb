ActiveAdmin.register Email do

	permit_params :subject, :body, :to, :user_id

	belongs_to :user, optional: true

	menu priority: 5

end
