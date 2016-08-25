ActiveAdmin.register Comment do

	permit_params :body, :commentable_id, :commentable_type, :comment_id

	belongs_to :user, optional: true

	menu priority: 6

end
