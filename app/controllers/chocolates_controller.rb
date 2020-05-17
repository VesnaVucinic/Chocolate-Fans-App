class ChocolatesController < ApplicationController
    def new
        @chocolate = Chocolate.new
        @chocolate.build_brand #becouse of nested form in new
    end

    
  private

  def chocolate_params
    params.require(:chocolate).permit(:category, :description, :brand_id, brand_attributes: [:name])
  end
end
