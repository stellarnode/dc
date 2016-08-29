ActiveAdmin.register Comment do

	permit_params :body, :commentable_id, :commentable_type, :comment_id

	belongs_to :user, optional: true

	menu parent: 'Posts', priority: 1

	index do
    selectable_column
    id_column
    column 'Model', :commentable_type
    column 'Model Obj.', :commentable_id
    column 'Body', :display_name
    column :user
  	column :parent_id
    column :created_at
    actions
  end

	filter :user
	filter :commentable_type, label: 'Model'
	filter :commentable_id, label: 'Model Object', as: :select, collection: proc { Post.all }
  filter :body
  filter :parent_id
  filter :children
  filter :created_at

end
