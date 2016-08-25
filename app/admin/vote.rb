ActiveAdmin.register Vote do

	permit_params :option_vote, :user_id, :option_id, :poll_option, votes_params: []

	belongs_to :poll, optional: true
	#belongs_to :option, optional: true

	menu parent: 'Polls', priority: 2

end