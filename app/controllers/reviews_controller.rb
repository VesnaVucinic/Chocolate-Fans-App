class ReviewsController < ApplicationController

    def new
        @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id
        @review = @chocolate.reviews.build #review must know chocolate it's associated with, instatead taht already know about chocolate 
    end

    def create
        @review = current_user.reviews.build(review_params)
        if @review.save
          redirect_to review_path(@review)
        else
          render :new
        end
    end

    def show#I don't to need to nested show page becouse one review belongs to only ine chocolate 
        @review = Review.find_by_id(params[:id])
    end

    def index
    end

    
    private

    def review_params
        params.require(:review).permit(:chocolate_id, :user_id, :content, :stars, :title)
    end
end
