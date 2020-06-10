class Chocolate < ApplicationRecord
  belongs_to :brand # belongs to gives us brand geter and setter method brend=, build_brand, brand_id geter and setter mmethod brend_id=
  belongs_to :user #creator of it, gives all singular instances
  has_many :reviews
  has_many :users, through: :reviews #people wh have reviewed it, gives all plural instances
  has_one_attached :image

  accepts_nested_attributes_for :brand #added becouse of neasted form in new chocolate and def new in chocolate controller

  validates :title, :category, :description, presence: true # built in validation always folowed by attribute to validate
  validate :not_a_duplicate #singular validate when we have written custom validator, folowed by method written to custom validate
  validate :acceptable_image
  #validates :title uniquness: {scope: :brand} but we made validate :not_a_duplicate as custom one
  
  #when I want to order chocolates by my reatings I nedd to combine chocolate and review table
  #when I do query command that aloweds me to combine two tables is join
  #test in console : I will get with Chocolate.joins(:reviews) that will give me for example first chocolate showed up twice becouse have multiple reviews
  #and all chocolates that have multiple reviews will show up more then once, we have multiple copises of same thing if they have more then one review
  #I want to take all ratings for same chocolate and averige them, but I need to get average only in group of one chocolate with multiple revievs
  #command count will be for chocolate with most reviews
  #command that aloweds me to group reviews by atributtes I want to group them by in this case id of chocolate 
  # after group(:id) I only see once listed one chocolate
  #after we group them we can averaging ratings and ordering them by their average rating
  #Chocolate.joins(:reviews).group(:id).order('avg(rating) desc')
  scope :order_by_rating, -> {left_joins(:reviews).group(:id).order('avg(rating) desc')} #this order will show in index page and be used in index action of chocolate_controller
  #just joins will give just chocolates that have rating, list chocolates only combined with review but I want all and left_joins will list also chocolates that don't have review
  #diference between include and joins, include is like preload recourse it's eager loads, joins doesn't load until the thing is needed, joins is laizy loads
  #incude preloads association whereas joins when is called

  #1. scope methodes are very specificly class level changing the collection methodes, methods and chage the scope of collection instead to look in all chocolates we are looking only in chocolates that have reviwes or
  #insted looking in chocolates in random order we are looking in chocolates in specific order
  #2. model methos are instance methodes, other model methodes can be once that quering the db
  #3. helper methodes are very specificly view methodes and only place I am ever gona use them are in view
  # def title_and_brand could be helper method but is ok to be here becouse pulling out attributes of the instance
  def self.alpha #scope method instead collection of chocolates in random order we have collection in alphabetic order
    order(:title) #active record SQL term I use is order
  end
  #next 4 methodes are model methodes  and they are instance methodes and they are quering the db
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

  def not_a_duplicate #instance method
    # if there is already an chocolate with that title && brand, throw an error
    if Chocolate.find_by(title: title, brand_id: brand_id) # I have direct access to attributes, title is just like calling self.title , just calling the attribute- instance.title

      #chocolate = Chocolate.find_by(title: title, brand_id: brand_id) # I have direct access to attributes, title is just like calling self.title , just calling the attribute- instance.title
      #if !!chocolate && chocolate != self
      errors.add(:title, 'has already been added for that brand')#this works capitalise Title has already been added for that brand 
    end
  end

  def brand_name
    brand.try(:name)
  end

  def title_and_brand #reader method to display title of chocolate and brand name
    "#{title} by #{brand.try(:name)}"##{brand.name}"
  end

end
