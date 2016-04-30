class Post < ActiveRecord::Base
  has_many :post_images
  has_many :images, through: :post_images

  validates :title, presence: true
  validates :description, presence: true
end
