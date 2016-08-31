ActiveAdmin.register Role do

	actions :index, :show

	permit_params :name, :resource_type, :resource_id

	belongs_to :user, optional: true

	menu parent: 'Users', priority: 2

	index do
		selectable_column
		id_column
		column 'Role', :name
		column 'Count Users' do |role|
			link_to role.users.count, admin_users_path(q: {roles_id_eq: role.id })
		end
		column :created_at
		actions
	end

	filter :users
	filter :name, label: 'Role', as: :select
	filter :created_at

end
