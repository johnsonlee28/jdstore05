class Graphic < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  belongs_to :comment
end
