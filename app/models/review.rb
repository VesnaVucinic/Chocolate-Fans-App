class Review < ApplicationRecord
  belongs_to :user
  belongs_to :chocolate
 

  validates :title, presence: true
  validates :rating, numericality: true 
  #validates :rating, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than: 6}


  validates :chocolate, uniqueness: { scope: :user, message: "has already been reviewed by you"  }
   #= this will validate uniquness of two things included, we say uniquness and then scope it, I only want user to
   # make one review for paticular chocolate, I only want someone to make one entry or only want it to happen once => if that chocolate id has already been added to the database, and I add custom message
   
   def blank_stars
    5 - rating.to_i
   end
end
