class Brand < ApplicationRecord
    has_many :chocolates
    validates :name, presence: true, uniqueness: true

    scope :alpha, -> {order(:name)}

end
