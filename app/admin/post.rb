ActiveAdmin.register Post do

  permit_params :title, :body, :user_id, :is_pinned, :is_draft, :commentable, :category_name, :show_me, 
                post_categories_attributes: [:category_id, :post_id, :id]

	includes :categories
  belongs_to :user, optional: true

	menu parent: 'Posts', priority: 0

	scope :all, default: true
	scope :published
	scope :draft
  scope :news

  index do
    selectable_column
    id_column
    column 'Title', :display_name
    column 'Body', sortable: :body do |post|
    	truncate(post.body, length: 50, separator: ' ')
  	end
    column 'Pinned', :is_pinned
    column 'Draft', :is_draft
    column 'Comm-ble', :commentable
    column 'Category' do |post|
      post.categories.first.name
    end
    column :user
    column 'Comments'  do |post|
      unless post.comment_threads.count == 0
        link_to post.comment_threads.count, admin_comments_path(q: {commentable_type_eq: 'Post', commentable_id_eq: post.id })
      else
        0
      end
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :title
      row :body
      row('Pinned') { status_tag(resource.is_pinned) }
      row('Draft') { status_tag(resource.is_draft) }
      row(:commentable) { status_tag(resource.commentable) }
      row('Category') do |post|
        post.categories.first.name
      end
      row :user
      row('Comments') do |post|
       post.comment_threads.count
      end      
      row :created_at
      row :updated_at
    end
  end

  filter :user
  filter :categories
  filter :title
  filter :body
  filter :is_pinned, label: 'Pinned', as: :check_boxes
  filter :is_draft, label: 'Draft', as: :check_boxes
  filter :commentable, as: :check_boxes
  filter :created_at

  sidebar 'Post details', only: [:show, :edit] do
    para strong link_to 'Post Comments', admin_comments_path(q: {commentable_type_eq: 'Post', commentable_id_eq: resource.id })
  end  

end