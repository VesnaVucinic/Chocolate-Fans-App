class Review < ApplicationRecord
  belongs_to :chocolate
  belongs_to :user
end
