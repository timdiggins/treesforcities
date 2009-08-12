class RootController < ApplicationController
  def homepage
    @lots = Lot.find :all, :include=>:tree 
#                :origin=> origin
#                :within => within
  end

end
