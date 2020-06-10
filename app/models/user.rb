class User < ApplicationRecord
    has_many :reviews
    has_many :reviewed_chocolates, through: :reviews, source: :chocolate # source is in review  belongs_to :chocolate no plural, exectly match like in review table
    #we need to tell to reviews table what is this refering to and it will refer to belongs_to :chocolate
    has_many :chocolates #that they have created user.chocolate
    
    validates :username, uniqueness: true,  presence: true #valu what is for login must have validation for uniquenss
    validates :email, uniqueness: true, presence: true
    # I made sure my app validates user input. I included has_secure_password method in user model which will authenticate against a Bcrypt password.
    # I used the active record helper method “presence” to ensure the specified attributes are not empty.

    has_secure_password #adds authomaticly authenticate method and says validation for password is true and also validate password coformation if there is one
   #I have access to has_secure_password through bcrypt and what it does is allowes to use ActiveRecord method call authenticate.
   # Authenticate take password as a plain string and checks it against bcrypts hashing algoritam to make sure that it's the correct password

    def self.create_by_github_omniauth(auth)
        self.find_or_create_by(uid: auth[:info][:id]) do |u|#alwaus return instance of user, if creates the user it will it will pass the newly instateated user to this block and alow me to set user password, save the user and then return that user
          #this 16 line of code fire SELECT "users" WHERE "users"."uid"IS NILL LIMIIT ? ["LIMIT",1]
          #if can't find it will INSERT INTO
          #first_or_initialize same as find_or_create_by
          #User.where(uid: auth[:info][:id]).first_or_initialize
          #we use do block to find user only using uid but then we are also able to set other atributes, it's the same as 
          #like @user = user.find_or_create_by and then underneath separatly st attributes of that user
          u.password = SecureRandom.hex #GARANTEE ENTIRALY RENDOM STRING NEVER BEEN GENERATED BEFORE
          #we must set password becouse next step is to set sessions[:id] and will not asign id if we don't have password and we will not have user this way
         #if user was created by omniouth we want that user only access their profile but also again going to Omniouth so we don't want they  they know their password and they can login
         # in the regular way, if you use third party login expextation is that you always use third-party login to log in, so they don't know their password and we set them random password
        #whole point of omniouth is to skip signup steps and have another password, niter of us know passwor get through omniouth, it' secure encrypted string used as password
        end
    end
  
end




#Define your User class to inherit from ActiveRecord(gem of ORM -object relational mapper that I am using throught this project)::Base(class within Activ Record gem am I going to inheret from)
#Thanks to that I don't need to create initialize, save, update method, they come from AR
#AR macros (or methods): has_many, belongs_to. They helped us associate user, chocolate, 
#The User class has gained a whole bunch of new methods via its inheritance relationship to ActiveRecord
#https://guides.rubyonrails.org/active_record_basics.html#creating-active-record-models