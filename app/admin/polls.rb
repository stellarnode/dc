ActiveAdmin.register Poll do

	includes :options, :votes

	permit_params :title, :body, :start, :finish, :state, :poll_type, :user_id, :show_me, :votes_count, 
								options_attributes: [:poll_option, :poll_id, :id, :_destroy]

	menu priority: 3


end
