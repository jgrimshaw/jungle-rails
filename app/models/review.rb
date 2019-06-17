class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :product, presence: true
  validates :user, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_equal_to: 5 }
end
