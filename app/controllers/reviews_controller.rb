class ReviewsController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :set_review, only:[:show, :edit, :update]

    def new
        # if it's nested
        if params[:chocolate_id] && @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id, that is 1 in nested rout chocolate/1/review/new
            @review = @chocolate.reviews.build #review must know chocolate it's associated with, instatead that already know about chocolate, belongs_to is @chocolate.reviews.build, chocolate has_many reviews
        else #if not nested
            @review = Review.new #instantiate new review 
        end
    end

    def create 
        #@review = Review.new(review_params)
        #@review.user_id = session[:user_id] -
        @review = current_user.reviews.build(review_params)# 2 row abowe will acomplish same thing like this one but someone could manipulate that in hidden field
        if @review.save
          redirect_to review_path(@review) #show path
        else
          render :new
        end
    end

    def show#I don't to need to nested show page becouse one review belongs to only one chocolate,already directly contains information of object associated with, we already selected one review and authomatilcly know chocolate
    end

    def index #for index need to be nested becouse I have all reviews for  chocolate
        #how do I chack if nested: chocolates/1/reviews, also chacks if is valid id not just nested
        if  #params[:chocolate_id]
            @chocolate = Chocolate.find_by_id(params[:chocolate_id])# once we have nesed rout it's not :id it's chocolate_id
            @reviews = @chocolate.reviews #if it's nested it will show reviews only for that one chocolate
        else
        #if it's not nested: /reviews
            @reviews = Review.all
        end
    end

    
    def edit
    end

    def update 
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
        @review = Review.find_by_id(params[:id])
        redirect_to reviews_path if !@review
    end


   
end
