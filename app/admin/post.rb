ActiveAdmin.register Post do

	includes :categories

	permit_params :title, :body, :user_id, :is_pinned, :is_draft, :commentable, :category_name, :show_me, 
								post_categories_attributes: [:category_id, :post_id, :id]

	menu priority: 2

	scope :all, default: true
	scope :published
	scope :draft
  scope :news

  index do
    selectable_column
    id_column
    column :title
    column "Body", sortable: :body  do |post|
    	truncate(post.body, length: 50, separator: ' ')
  	end
    column :is_pinned
    column :is_draft
    column :commentable
    column :created_at
    column :updated_at
    column :category
    column :user
    column "Comments" do |post|
    	post.comment_threads.count
  	end
    actions
  end

	preserve_default_filters!
	remove_filter :roles, :post_categories

end