ActiveAdmin.register Category do

	permit_params :name

	belongs_to :post, optional: true

	menu priority: 7

end
