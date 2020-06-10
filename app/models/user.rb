class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_chocolates, through: :reviews, source: :chocolate 
    has_many :chocolates #that they have created user.chocolate
    
    validates :username, uniqueness: true,  presence: true 
    validates :email, uniqueness: true, presence: true
    
    has_secure_password 

    def self.create_by_github_omniauth(auth)
        self.find_or_create_by(uid: auth[:info][:id]) do |u|
          #User.where(uid: auth[:info][:id]).first_or_initialize
          u.password = SecureRandom.hex 
        end
    end
  
end




