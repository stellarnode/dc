# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

Category.delete_all

name_collection = ['Buy', 'Sell', 'News', 'Help']

name_collection.size.times do |x|
	Category.create(name: name_collection[x] )
end

puts 'Categories created'