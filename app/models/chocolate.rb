class Chocolate < ApplicationRecord
  belongs_to :brand 
  belongs_to :user 
  has_many :reviews
  has_many :users, through: :reviews 
  has_one_attached :image

  accepts_nested_attributes_for :brand 

  validates :title, :category, :description, presence: true 
  validate :not_a_duplicate 
  validate :acceptable_image
  #validates :title uniquness: {scope: :brand} but we made validate :not_a_duplicate as custom one
  
  
  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')}

  def self.alpha
    order(:title) 
  end
  
  def brand_attributes=(attributes)
    self.brand = Brand.find_or_create_by(attributes) if !attributes['name'].empty?
    self.brand
  end

  def thumbnail
    self.image.variant(resize: "300x300")
  end

  def acceptable_image
    return unless image.attached?
  
    unless image.byte_size <= 1.megabyte
      errors.add(:image, "is too big")
    end
  
    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG or PNG")
    end
  end

  def not_a_duplicate 
     chocolate = Chocolate.find_by(title: title, brand_id: brand_id) 
      if !!chocolate && chocolate != self
      errors.add(:title, 'has already been added for that brand')
    end
  end

  def brand_name
    brand.try(:name)
  end

  def title_and_brand 
    "#{title} by #{brand.try(:name)}"
  end


end
