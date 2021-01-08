# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FoodBank.destroy_all
GroceryStore.destroy_all
Trip.destroy_all
Volunteer.destroy_all
FoodItem.destroy_all


Volunteer.create(name: "Manager",username: "Manager", location: 1, password_digest: "whatever")


FoodBank.create({name: "Hopelink", username:"hopelink", password_digest:"abcd", location: (1..20).to_a.sample})
FoodBank.create({name: "Ballard Food Bank", username:"bfb", password_digest:"abcd", location: (1..20).to_a.sample})
FoodBank.create({name: "Giving Tree", username:"givingtree", password_digest:"abcd", location: (1..20).to_a.sample})
FoodBank.create({name: "Helping Hand", username:"helpinghand", password_digest:"abcd", location: (1..20).to_a.sample})

GroceryStore.create({name: "Ralphs",location: (1..20).to_a.sample})
GroceryStore.create({name: "Vons",location: (1..20).to_a.sample})
GroceryStore.create({name: "Albertsons",location: (1..20).to_a.sample})
GroceryStore.create({name: "Grocery Outlet",location: (1..20).to_a.sample})
GroceryStore.create({name: "Safeway",location: (1..20).to_a.sample})
GroceryStore.create({name: "QFC",location: (1..20).to_a.sample})
GroceryStore.create({name: "Trader Joes",location: (1..20).to_a.sample})
GroceryStore.create({name: "Fred Meyer",location: (1..20).to_a.sample})
GroceryStore.create({name: "Target",location: (1..20).to_a.sample})
GroceryStore.create({name: "Central Market",location: (1..20).to_a.sample})

10.times do
  Trip.create({
    grocery_store_id: GroceryStore.all.map{|f|f.id}.sample,
    food_bank_id: FoodBank.all.map{|f|f.id}.sample,
    volunteer_id: Volunteer.find_by(username: "Manager").id
  })
end

500.times do
  FoodItem.create({
    name: Faker::Food.ingredient,
    owner_type: "GroceryStore",
    owner_id: GroceryStore.all.map{|g| g.id}.sample
  })
end

50.times do
  FoodItem.create({
    name: Faker::Food.ingredient,
    owner_type: "Trip",
    owner_id: Trip.all.map{|g| g.id}.sample
  })
end

10.times do
  FoodItem.create({
    name: Faker::Food.ingredient,
    owner_type: "FoodBank",
    owner_id: 9
  })
end

puts "yay"