# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb
puts "Seeding admin user..."
AdminUser.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |admin|
  admin.password = ENV['ADMIN_PASSWORD']
  admin.password_confirmation = ENV['ADMIN_PASSWORD']
  # Add other mandatory fields if necessary
end
puts "Admin user created/verified: #{ENV['ADMIN_EMAIL']}"
