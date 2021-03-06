class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  has_many :likes, :dependent => :destroy
  has_many :liked_products, :through => :likes, :source => :product

  has_many :collects, :dependent => :destroy
  has_many :collected_products, :through => :collects, :source => :product

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def admin?
    is_admin
  end

  has_many :comments


end
