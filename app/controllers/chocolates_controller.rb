class ChocolatesController < ApplicationController
    def new
        @chocolate = Chocolate.new
    end
end
