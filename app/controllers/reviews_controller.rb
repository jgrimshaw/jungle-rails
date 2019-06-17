class ReviewsController < ApplicationController
  def create
    if create_review
      redirect_to @review.product
    else
      reirect_to @review.product, error: "your review can not be created."
    end
  end

private

  def review_params
    params.require(:review).permit(:rating, :description)
  end

  def create_review
    @review = current_user.reviews.create(review_params.merge({
      product_id: params[:product_id]
    }))
  end
end