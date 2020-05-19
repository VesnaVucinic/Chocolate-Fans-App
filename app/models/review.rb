class Review < ApplicationRecord
  belongs_to :user
  belongs_to :chocolate
 

  validates :title, presence: true
  validates :stars, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than: 6}

  validates :chocolate, uniqueness: { scope: :user, message: "has already been reviewed by you"  }
   #custom message, validate og 2 things icluded, I only want users to make one review for chocolate,
   # can't review twice same chocolate, gives nicer erroe message

  
end
