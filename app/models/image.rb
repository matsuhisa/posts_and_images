class Image < ActiveRecord::Base
  has_many :post_images
  has_many :posts, through: :post_images
end
