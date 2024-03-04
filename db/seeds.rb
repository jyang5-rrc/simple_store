# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

#test using invalid date
# invalid_product = Product.new(price: 10, stock_quantity: 5)
# if invalid_product.save
#   puts "Product saved successfully."
# else
#   puts "Failed to save product: #{invalid_product.errors.full_messages.join(", ")}"
# end

#populate 676 products with fake data
require "faker"

# set the random seed to get the same data every time
Faker::Config.random = Random.new(42)

676.times do
  Product.create(
    title: Faker::Commerce.product_name,
    price: Faker::Commerce.price(range: 0..100.0, as_string: true),
    stock_quantity: Faker::Number.between(from: 0, to: 100)
  )
end

puts "676 products created successfully."




