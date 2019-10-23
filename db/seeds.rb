# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.new(name: "Admin", phone: "1111111111", email: "admin@gmail.com", password: "123123", password_confirmation: "123123")
admin.confirm
admin.admin!
admin.save

member = User.new(name: "Test", phone: "1111111111", email: "test@gmail.com", password: "123123", password_confirmation: "123123")
member.confirm
member.save

9.times do |discount|
  name = FFaker::Code.ean
  number = rand(10..25)
  desc = "Giam gia den #{number}"
  Discount.create!(name: name, discount_value: number, description: desc)
end

20.times do |table|
  type_table = table % (Table.type_tables.length)
  desc = "Floor #{table/10}"
  Table.create!(type_table: type_table, description: desc)
end

6.times do |catalog|
  name = "catalog #{catalog}"
  desc = FFaker::Book.description[0..490]
  Catalog.create(name: name, description: desc)
end

10.times do |post|
  title = "title #{post}"
  content = FFaker::Book.description
  Post.create(title: title, content: content, user_id: admin.id, catalog_id: rand(1..6))
end

10.times do |post|
  title = "title #{post}"
  content = FFaker::Book.description
  Post.create!(title: title, content: content, user_id: admin.id, catalog_id: rand(1..6))
end

3.times do |food|
  name = FFaker::Food.meat + " #{food}"
  desc = name + " #{food}"
  price = rand(500000..5000000)
  cost = rand(price..6000000)
  Food.create!(name: name, description: desc, price: price, cost: cost)
end

3.times do |food|
  name = FFaker::Food.fruit + " #{food}"
  desc = name + " #{food}"
  price = rand(500000..5000000)
  cost = rand(price..6000000)
  Food.create!(name: name, description: desc, price: price, cost: cost)
end

3.times do |food|
  name = FFaker::Food.vegetable + " #{food}"
  desc = name + " #{food}"
  price = rand(500000..5000000)
  cost = rand(price..6000000)
  Food.create!(name: name, description: desc, price: price, cost: cost)
end
