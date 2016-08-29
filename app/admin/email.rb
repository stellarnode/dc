ActiveAdmin.register Email do

	permit_params :subject, :body, :to, :user_id

	belongs_to :user, optional: true

	menu priority: 5

	index do
    selectable_column
    id_column
    column :user
    column :to
    column 'Subject', :display_name
    column 'Body', sortable: :subject  do |email|
    	truncate(email.body, length: 40, separator: ' ')
  	end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row('To') { mail_to(resource.to) }
      row :subject
      row :body
      row :created_at
      row :updated_at
    end
  end

  filter :user
  filter :to
  filter :subject
  filter :body
  filter :created_at

end
