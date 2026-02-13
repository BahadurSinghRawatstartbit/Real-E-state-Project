# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

admin = User.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |user|
  user.name = "Admin"
  user.password = ENV['ADMIN_PASSWORD']
  user.password_confirmation = ENV['ADMIN_PASSWORD']
end

admin.add_role(:admin) unless admin.has_role?(:admin)

puts "Admin user created/verified: #{admin.email}"

puts "Seeding admin user..."

admin = User.find_or_initialize_by(email: ENV['ADMIN_EMAIL'])

admin.name = "Admin"
admin.password = ENV['ADMIN_PASSWORD']
admin.password_confirmation = ENV['ADMIN_PASSWORD']
admin.add_role(:admin) if admin.respond_to?(:add_role?)

admin.save!

puts "Admin user created/verified: #{admin.email}"