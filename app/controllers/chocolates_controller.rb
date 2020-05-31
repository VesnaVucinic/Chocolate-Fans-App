class ChocolatesController < ApplicationController
    before_action :redirect_if_not_logged_in

    def index
        @chocolates = Chocolate.order_by_rating.includes(:brand)
    end

    def show
        @chocolate = Chocolate.find_by_id(params[:id])
    end
!
    def new
        @chocolate = Chocolate.new
        @chocolate.build_brand #becouse of nested form in new
    end


    def create
        @chocolate = Chocolate.new(chocolate_params)
        @chocolate.user_id = session[:user_id] # becouse we have user.id in chocolate table
        if @chocolate.save #this is where validations happen
            redirect_to chocolate_path(@chocolate)
        else
            render :new
        end
    end

  
    
    private

    def chocolate_params
        params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id, :image, brand_attributes: [:name])
    end

    def set_ice_cream
        @chocolate = Chocolate.find_by(params[:id])
        redirect_to chocolates_path if !@chocolate
    end
end
