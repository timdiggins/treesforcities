require "#{File.dirname(__FILE__)}/../test_helper"

module EveryoneShould
  def self.included(klass)
    klass.class_eval do  
      
      should "be able to view homepage successfully" do
        get("/")
        assert_response_ok
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