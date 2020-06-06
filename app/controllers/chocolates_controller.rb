class ChocolatesController < ApplicationController
    before_action :set_chocolate, only:[:show, :edit, :update]
    before_action :redirect_if_not_logged_in

    def index
        @chocolates = Chocolate.order_by_rating
    end

    def show
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

    # def update
    #    if @chocolate.update(chocolate_params)
    #         @chocolate.image.purge
    #         @chocolate.image.attach(params[:chocolate][:image])
    #         redirect_to chocolate_path(@chocolate)
    #     else
    #         render :edit
    #     end 
    # end

    def update
        if  @chocolate.update(chocolate_params_image)
            redirect_to chocolate_path(@chocolate)
        else
            render :edit
        end  
    end

    # def update_params_without_image
    #     if  @chocolate.update(chocolate_update_params_without_image)
    #         redirect_to chocolate_path(@chocolate)
    #     else
    #         render :edit
    #     end  
    # end
   
      
    
    private

    def chocolate_params
        params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id, :image,  brand_attributes: [:name])
    end

    def chocolate_params_image
        if params[:chocolate][:image]==""
            params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id,   brand_attributes: [:name])
        else
            params.require(:chocolate).permit(:title, :category, :description, :user_id, :brand_id, :image,  brand_attributes: [:name])
        end
    end

    # def chocolate_update_params_without_image
    #     params.require(:chocolate).permit(:title,:category, :description, :user_id, :brand_id, brand_attributes: [:name])
    # end

    def set_chocolate
        @chocolate = Chocolate.find_by_id(params[:id])
        redirect_to chocolates_path if !@chocolate
    end
end

