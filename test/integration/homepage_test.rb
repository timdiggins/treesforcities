require "#{File.dirname(__FILE__)}/../test_helper"

module EveryoneShould
  def self.included(klass)
    klass.class_eval do  
      
      should "be able to see homepage successfully" do
        get("/")
        assert_response_ok
      end      
      
      should "be able to see home page when no trees" do
        Tree.destroy_all
        get_ok '/'
      end
      
      
    end
  end
  
end


class HomepageTest < ActionController::IntegrationTest
  
  context "normally" do
    include EveryoneShould  
  end
  
  context "logged in" do
    setup do
      login!(:quentin)
    end
    include EveryoneShould    
  end
end