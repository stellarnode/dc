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
#TODO: choose better variant
#    column 'Parent' do |comment|
#      if comment.parent_id.nil?
#        nil
#      else
#        link_to comment.parent_id, admin_comment_path(id: comment.parent_id)
#      end
#    end  	
    column :created_at
    actions
  end

end
