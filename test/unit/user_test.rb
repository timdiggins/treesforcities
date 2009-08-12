require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  context "Class" do
    should "be able to auth quentin" do
      puts "REST_AUTH_SITE_KEY: #{REST_AUTH_SITE_KEY}"
      q = User.authenticate(users(:quentin).login, "monkey")
      assert !q.nil?
    end
    
    should "be able to authenticate a user" do
      a = User.authenticate(users(:alex).login, "monkey")
      assert !a.nil?
    end
    
  end
end