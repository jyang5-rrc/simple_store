class ProductsController < ApplicationController
  def index
    @products = Product.includes(:category).all # N+1 avoidance means that we want to avoid making a separate database query for each product's category. We can do this by using the includes method to load all the categories at once.
  end

  def show
    @product = Product.includes(:category).find(params[:id])
  end
end
