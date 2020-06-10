class ChocolatesController < ApplicationController
    before_action :set_chocolate, only:[:show, :edit, :update, :longest_title]
    before_action :redirect_if_not_logged_in

    def index
        @chocolates = Chocolate.order_by_rating.includes(:brand)
    end

    def show
    end

    def new
        @chocolate = Chocolate.new
        @chocolate.build_brand
    end


    def create
         @chocolate = current_user.chocolates.build(chocolate_params)
        if @chocolate.save 
            @chocolate.image.purge
            @chocolate.image.attach(params[:chocolate][:image])
            redirect_to chocolate_path(@chocolate)
        else
            @chocolate.build_brand
            render :new
        end
    end

    def edit
    end

    def update
        if  @chocolate.update(chocolate_params)
            redirect_to chocolate_path(@chocolate)
        else
            render :edit
        end  
    end
   
    def longest_title
    end
        
    private


    def chocolate_params
        if params[:chocolate][:image]==""
            params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id,   brand_attributes: [:name])
        else
            params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id, :image,  brand_attributes: [:name])#brand_attributes: [:name] becouse of neasted form
        end
    end


    def set_chocolate
        @chocolate = Chocolate.find_by_id(params[:id])
        redirect_to chocolates_path if !@chocolate
    end
end

