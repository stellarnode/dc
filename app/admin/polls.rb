ActiveAdmin.register Poll do

	permit_params :title, :body, :start, :finish, :state, :poll_type, :user_id, :show_me, :votes_count, 
								options_attributes: [:poll_option, :poll_id, :id, :_destroy]
	includes :options, :votes
	belongs_to :user, optional: true

	menu parent: 'Polls', priority: 0

end
