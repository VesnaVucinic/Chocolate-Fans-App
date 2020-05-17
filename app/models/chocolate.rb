class Chocolate < ApplicationRecord
  belongs_to :brand
  belongs_to :user #creator of it, gives all singular instances
  has_many :reviews
  has_many :users, through: :reviews #people wh have reviewed it, gives all plural instances
end
