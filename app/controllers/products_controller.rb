class ProductsController < ApplicationController
  def index
    @prodcut = Product.all
  end
end
