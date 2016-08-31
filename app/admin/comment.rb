ActiveAdmin.register Comment do

	actions :all, except: [:new, :create]

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

	show do
		attributes_table do
			row :id
			row('Model') { resource.commentable_type }
			row('Model Obj.') { link_to Post.where(id: resource.commentable_id).first.title, admin_post_path(id: resource.commentable_id) }
			row('Body') { resource.body }
			row :user
			row :parent_id
			row :title
			row :subject
			row :lft
			row :rgt
			row :created_at
			row :updated_at
		end
	end

	form do |f|
		f.semantic_errors *f.object.errors
		f.inputs "Comment Details" do
			li para strong "User: #{resource.user.username}"
			li para strong "Parent comment: \"#{resource.parent.body}\""
			li para strong "Model: #{resource.commentable_type}"
			li para strong "Model id: #{resource.commentable_id}"
			f.input :body
		end
		f.actions
	end

	filter :user
	filter :commentable_type, label: 'Model'
	filter :commentable_id, label: 'Model Object', as: :select, collection: proc { Post.all }
	filter :body
	filter :parent_id
	filter :children
	filter :created_at

end
