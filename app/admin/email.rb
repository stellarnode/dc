ActiveAdmin.register Email do

	permit_params :subject, :body, :to, :user_id

	menu priority: 5

end
