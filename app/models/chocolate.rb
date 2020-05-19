class Chocolate < ApplicationRecord
  belongs_to :brand # belongs to gives us brand geter and setter method brend=, build_brand, brand_id geter and setter mmethod brend_id=
  belongs_to :user #creator of it, gives all singular instances
  has_many :reviews
  has_many :users, through: :reviews #people wh have reviewed it, gives all plural instances

  #accepts_nested_attributes_for :brand

  validates :name, :category, :description, presence: true
  
  
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand
  end
end
