class RootController < ApplicationController
  def homepage
    @trees = Tree.find :all
  end

end
