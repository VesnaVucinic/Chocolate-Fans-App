class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest #in order to encrypt password, I am using bcrypt in my gemfile
      #this is column where are be encrypted password once it has encrypted, 
      #right away I need in my user model to all macro has_secure_password

      t.timestamps
    end
  end
end
