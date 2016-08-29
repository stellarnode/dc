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
    id_column
    column 'Title', :display_name
    column 'Body', sortable: :body do |poll|
    	truncate(poll.body, length: 40, separator: ' ')
  	end
    column :start
    column :finish
    column 'State', sortable: :state do |poll|
      status_tag(poll.state)
    end
		column :poll_type, sortable: :poll_type do |poll|
      status_tag(poll.poll_type)
    end
		column :user
    column 'Votes', sortable: :votes_count do |poll|
      unless poll.votes.blank?
        link_to poll.votes.size, admin_votes_path(q: { poll_id_eq: poll.id })
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
      row :start
      row :finish
      row(:state) { status_tag(resource.state) }
      row(:poll_type) { status_tag(resource.poll_type) }
      row :user
      row('Votes') { resource.votes_count }
      row :created_at
      row :updated_at
    end
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
    para strong link_to "Poll Votes (#{poll.votes.size})", admin_votes_path(q: { poll_id_eq: resource.id })
    resource.options.each_with_index do |option, index|
    	para "Opt. #{index + 1}: \"" + option.display_name.to_s + '" - ' + option.votes.size.to_s + ' votes'
    end
  end

end
