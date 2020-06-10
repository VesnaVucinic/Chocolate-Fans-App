class Review < ApplicationRecord
  belongs_to :user
  belongs_to :chocolate
 

  validates :title, presence: true
  validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than: 6}


  validates :chocolate, uniqueness: { scope: :user, message: "has already been reviewed by you"  }
   
   def blank_stars
    5 - rating.to_i
   end
end
