require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  context "Class" do
    should "be able to auth quentin" do
      q = User.authenticate(users(:quentin).login, "monkey")
      assert !q.nil?
    end
    
    should "be able to authenticate a user" do
      a = User.authenticate(users(:alex).login, "monkey")
      assert !a.nil?
    end
    
  end
end