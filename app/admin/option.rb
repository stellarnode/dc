ActiveAdmin.register Option do

	permit_params :poll_option, :poll_id
	
	includes :votes
	belongs_to :poll, optional: true
	
	menu parent: 'Polls', priority: 1

end