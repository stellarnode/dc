ActiveAdmin.register Post do

	includes :categories

	permit_params :title, :body, :user_id, :is_pinned, :is_draft, :commentable, :category_name, :show_me, 
								post_categories_attributes: [:category_id, :post_id, :id]

	menu priority: 2

	scope_to :all, default: true
	scope_to :published
	scope_to :draft
  scope_to :news

	preserve_default_filters!
	remove_filter :roles, :post_categories

end