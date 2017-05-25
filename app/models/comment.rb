class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :graphics
  accepts_nested_attributes_for :graphics
  validates :rating, presence: true 
end
