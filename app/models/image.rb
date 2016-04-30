class Image < ActiveRecord::Base
  has_many :post_images
  has_many :posts, through: :post_images

  attr_accessor :file
end
