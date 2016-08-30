ActiveAdmin.register Identity do

	actions :index, :show

	permit_params :user_id, :provider, :uid

	belongs_to :user, optional: true

	menu parent: 'Users', priority: 3

	index do
		selectable_column
		id_column
		column :provider
		column :uid
		column :user
		column :created_at
		actions
	end

	filter :user
	filter :provider, as: :select
	filter :uid
	filter :created_at

end
