class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_chocolates, through: :reviews, source: :chocolate #no plural, exectly match like in review table
    
    has_many :chocolates #that they have created
    
    validates :username, uniqueness: true,  presence: true
    validates :email, presence: true

    has_secure_password #adds authomaticly authenticate method and says validation for password is true and also validate password coformation if there is one
end
