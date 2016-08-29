ActiveAdmin.register Category do

	permit_params :name

	includes :posts
	belongs_to :post, optional: true

	menu parent: 'Posts', priority: 2

	index do
    selectable_column
    id_column
    column 'Name' do |category|
      link_to category.name, admin_category_path(category)
    end
    column 'Posts'  do |category|
      unless category.posts.size == 0
        link_to category.posts.size, admin_posts_path(q: {post_categories_category_id_eq: category.id })
      else
        0
      end
    end
    column :created_at
    actions
  end

  preserve_default_filters!
	remove_filter :updated_at, :post_categories

  sidebar 'Category details', only: [:show, :edit] do
    para strong link_to 'Category Posts', admin_posts_path(q: {post_categories_category_id_eq: resource.id })
  end  

end
