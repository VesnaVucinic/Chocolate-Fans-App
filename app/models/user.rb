class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_chocolates, through: :reviews, source: :chocolate #no plural, exectly match like in review table
    
    has_many :chocolates #that they have created
    
end
