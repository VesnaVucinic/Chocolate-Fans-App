module ApplicationHelper

    def render_nav_bar
        if logged_in?
          render partial: 'layouts/loggedin_links'
       
        end
    end

    def render_loggedout_links
        render partial: 'layouts/loggedout_links'
    end
end
