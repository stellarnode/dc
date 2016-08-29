ActiveAdmin.register Option do

	permit_params :poll_option, :poll_id
	
	includes :votes
	belongs_to :poll, optional: true
	
	menu parent: 'Polls', priority: 1

	index do
    selectable_column
    id_column
    column :poll
    column 'Body', :display_name
    column 'Votes'  do |option|
	  	unless option.votes.blank?
	  		link_to option.votes.size, admin_option_votes_path(option)
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
      row('Body') { resource.poll_option }
      row('Votes') { resource.votes_count }
      row :poll
      row :created_at
      row :updated_at
    end
  end

  filter :poll
  filter :poll_option, label: 'Options'
  filter :created_at

  sidebar 'Option details', only: [:show, :edit] do
    para strong link_to "Option Votes", admin_option_votes_path(resource)
  end

end