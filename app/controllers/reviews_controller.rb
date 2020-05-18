class ReviewsController < ApplicationController

    def new
        @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id
        @review = @chocolate.reviews.build #review must know chocolate it's associated with, instatead taht already know about chocolate 
    end

    def index
    end

    
    private

    def review_params
        params.require(:review).permit(:chocolate_id, :content, :stars, :title)
    end
end
