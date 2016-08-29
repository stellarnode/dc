ActiveAdmin.register Category do

	permit_params :name

	includes :posts
	belongs_to :post, optional: true

	menu parent: 'Posts', priority: 2

	index do
    selectable_column
    id_column
    column :name
    column 'Posts' do |category|
			category.posts.size
  	end 
    column :created_at
    actions
  end

  preserve_default_filters!
	remove_filter :updated_at, :post_categories

end
