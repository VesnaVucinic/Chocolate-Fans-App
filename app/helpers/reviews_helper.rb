module ReviewsHelper

    def display_header(review)
      if params[:chocolate_id]
          content_tag(:h1, "Add a Review for #{review.chocolate.title} -  #{review.chocolate.brand.name}")
      else
        content_tag(:h1, "Create a review")
      end
    end
end
