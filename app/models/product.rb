class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def rating
    r = reviews.pluck(:rating)
    return 0 if r.sum < 1 || r.length < 1
    r.sum / r.length
  end

end
