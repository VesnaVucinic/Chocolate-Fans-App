class BrandsController < ApplicationController
  before_action :redirect_if_not_logged_in

    
  def index
    @brands = Brand.alpha
  end

  # def new
  #   @brand = Brand.new
  # end

  # def create
  #   @brand = Brand.create(brand_params)
  #   redirect_to brands_path(@brands)
  # end

  # private

  # def brand_params
  #   params.require(:brand).permit(:name)
  # end

    
end
