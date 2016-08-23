ActiveAdmin.register Vote do

	permit_params :option_vote, :user_id, :option_id, :poll_option, votes_params: []

	menu priority: 10

end