class BrandsController < ApplicationController

    
  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.create(brand_params)
    redirect_to brands_path(@brands)
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

    
end
