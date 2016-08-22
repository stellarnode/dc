# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])


# Fill default Category table
['Buy', 'Sell', 'News', 'Help', 'Other'].each do |category|
	Category.find_or_create_by(name: category)
end
puts 'Categories created'

# Create first user to have access to admin dashboard
# Don't fogret to change it to your data
User.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
puts "First user created. Don't fogret to change it to your data in Admin Dashboard!"