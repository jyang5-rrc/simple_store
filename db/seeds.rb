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
# require "faker"

# # set the random seed to get the same data every time
# Faker::Config.random = Random.new(42)

# 676.times do
#   Product.create(
#     title: Faker::Commerce.product_name,
#     price: Faker::Commerce.price(range: 0..100.0, as_string: true),
#     stock_quantity: Faker::Number.between(from: 0, to: 100)
#   )
# end

# puts "676 products created successfully."

#pull data from csv file
require "csv"

csv_file = Rails.root.join("db/products.csv") # path to the csv file containing the data
csv_data = File.read(csv_file)# read the file into a string using the File.read method

products = CSV.parse(csv_data, headers: true, encoding: "ISO-8859-1") # parse the CSV data into an array of rows using the CSV.parse method,headers: true option to tell the parser to treat the first row as headers

new_products = []
current_time = Time.current

products.each do |product|

  # create categories
  category = Category.find_or_create_by!(name: product["category"]) # find a category with the name from the CSV file in the database so that we don't create duplicate categories
  # create products
  new_product = Product.new(
    title: product["name"],
    description: product["description"],
    price: product["price"],
    stock_quantity: product["stock quantity"],
    category_id: category.id,
    created_at: current_time,
    updated_at: current_time

  )# create a new product object with the data from the CSV file

  # if new_product.save
  #   puts "Product created successfully."
  # else
  #   puts "Failed to create product: #{new_product.errors.full_messages.join(", ")}"
  # end

  new_products << new_product
end

Product.insert_all!(new_products.map(&:attributes))# use the insert_all! method to insert all the new products into the database in a single query
puts "Products created successfully."# print a message to the console to indicate that the products were created successfully


