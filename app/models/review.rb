class Review < ApplicationRecord
  belongs_to :user
  belongs_to :chocolate
 

  validates :title, presence: true
  validates :rating, numericality: true 

  validates :chocolate, uniqueness: { scope: :user, message: "has already been reviewed by you"  }
   #validate og 2 things icluded, I only want users to make one review for chocolate,
   # can't review twice same chocolate, gives nicer erroe message custom message, 

   def blank_stars
    5 - rating.to_i
   end
end
