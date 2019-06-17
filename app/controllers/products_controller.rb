class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @review = @product.reviews.build
    @reviews = @product.reviews.select {|r| r.persisted? }
  end

end
