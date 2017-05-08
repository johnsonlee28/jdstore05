class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :category

  has_many :photos
  has_many :comments 

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    self.likes.where( :user_id => user.id).first
  end

  accepts_nested_attributes_for :photos
end
