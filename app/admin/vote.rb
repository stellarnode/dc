ActiveAdmin.register Vote do

	permit_params :option_vote, :user_id, :option_id, :poll_option, votes_params: []

	belongs_to :option, optional: true

	menu parent: 'Polls', priority: 2

	index do
    selectable_column
    id_column
    column :poll
    column :option
    column :user
    column 'Weight', :option_vote
    column :created_at
    actions
  end

  filter 	:user
  filter 	:poll
  filter 	:option
  filter 	:created_at

end