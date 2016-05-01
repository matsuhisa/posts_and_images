class Image < ActiveRecord::Base
  has_many :post_images
  has_many :posts, through: :post_images

  validates :extension, presence: true, image_extension: true

  attr_accessor :file
end
