ActiveAdmin.register Poll do

	permit_params :title, :body, :start, :finish, :state, :poll_type, :user_id, :show_me, :votes_count, 
								options_attributes: [:poll_option, :poll_id, :id, :_destroy]
	includes :options, :votes
	belongs_to :user, optional: true

	menu parent: 'Polls', priority: 0

	scope :all, default: true
	scope	:created
	scope	:opened
	scope	:closed

  index do
    selectable_column
    column 'Title', :display_name
    column 'Body', sortable: :body  do |post|
    	truncate(post.body, length: 40, separator: ' ')
  	end
    column 	:start
    column 	:finish
    column 	:state
		column 	:poll_type
		column 	:user
    column 	:created_at
    actions
  end

  filter 	:user
  filter 	:title
  filter 	:body
  filter 	:poll_type, as: :select
  filter 	:start
  filter 	:finish
  filter 	:created_at

  sidebar 'Poll details', only: [:show, :edit] do
    para strong link_to 'Poll Options', admin_poll_options_path(resource)
    resource.options.each_with_index do |option, index|
    	para "Opt. #{index + 1}: \"" + option.display_name.to_s + '" - ' + option.votes.size.to_s + ' votes'
    end
  end

end
