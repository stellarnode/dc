ActiveAdmin.register Comment do

	permit_params :body, :commentable_id, :commentable_type, :comment_id

	menu priority: 6

end
