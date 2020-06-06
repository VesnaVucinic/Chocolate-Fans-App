class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_review, only:[:show, :edit, :update]

    def new
        # if it's nested
        if params[:chocolate_id] && @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id
            @review = @chocolate.reviews.build #review must know chocolate it's associated with, instatead taht already know about chocolate 
        else #if not nested
            @review = Review.new
        end
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
        #how do I chack if nested: chocolates/1/reviews, also chacks if is valid id not just nested
        if  @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id
            @reviews = @chocolate.reviews
        else
        #if it's not nested: /reviews
            @reviews = Review.all
        end
    end

    
    def edit
        @review = Review.find_by(id: params[:id])
    end

    def update 
        @review = Review.find_by(id: params[:id])
        if @review.update(review_params)
        redirect_to review_path(@review)
        else
        render :edit
        end
    end

    
    private

    def review_params
        params.require(:review).permit(:chocolate_id, :user_id, :content, :rating, :title)
    end
    
    def set_review
        @review = Review.find_by(params[:id])
        redirect_to reviews_path if !@review
    end


   
end
