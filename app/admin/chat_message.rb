ActiveAdmin.register ChatMessage do

	permit_params :message

	belongs_to :user, optional: true

	menu priority: 8

	index do
    selectable_column
    id_column    
    column :user
    column 'Message', :display_name
    column 	:created_at
    actions
  end

  preserve_default_filters!
	remove_filter :updated_at

end
