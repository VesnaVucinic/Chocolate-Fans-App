class ChocolatesController < ApplicationController

    def index
        @chocolates = Chocolate.all
    end

    def new
        @chocolate = Chocolate.new
        @chocolate.build_brand #becouse of nested form in new
    end


    def create
        @chocolate = Chocolate.new(chocolate_params)
        @ice_cream.user_id = session[:user_id] # becouse we have user.id in chocolate table
        if @chocolate.save #this is where validations happen
            redirect_to chocolate_path(@chocolate)
        else
            render :new
        end
     end
    
  private

  def chocolate_params
    params.require(:chocolate).permit(:category, :description, :brand_id, brand_attributes: [:name])
  end
end
