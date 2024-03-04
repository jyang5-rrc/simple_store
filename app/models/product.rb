class Product < ApplicationRecord
  # validation
  validates :title, presence:true
  validates :price, presence:true
  validates :stock_quantity, presence:true
end
