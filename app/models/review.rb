class Review < ApplicationRecord
  belongs_to :chocolate
  belongs_to :user

  validates :title, presence: true
  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than: 6}


  
end
