module ReviewsHelper
  #on helpers folder controller can't access this is only for desplaying in view
#abstracting logic from views and use ruby code and we can't use here html tags
#helper methods is how something will be desplayed whereas model methods are doing staff like grabbing info from db and scope our model methods but our class level model methodes
def display_header(review)
      if params[:chocolate_id] 
          #we use content_tag then send information as arguments and use ruby type of interpolation instead erb type of interploation
          content_tag(:h1, "Add a Review for #{review.chocolate.title} -  #{review.chocolate.brand.name}")# desplay this if is nested
      else
        content_tag(:h1, "Create a review")# display this if not nested
      end
    end
end

# <% if params[:chocolate_id] %>
#   <h1>"Add a Review for <%=review.chocolate.title %> - <%= review.chocolate.brand.name %></h1>
# <% else %>
#   <h1>Create a review</h1>
# <% end %>


