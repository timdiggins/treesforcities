require "#{File.dirname(__FILE__)}/../test_helper"

class LoginAndOutTest < ActionController::IntegrationTest

  context "normally" do
    should "be able to login and out" do
      get("/")
      assert_response_ok
      
      get('/login')
      assert_has_login_form
      
      login(users(:alex).login)
      assert_response_ok
      assert_doesnt_have_login_form      
      
      get("/")
      assert_doesnt_have_login_form      
      assert_select "a[href=/logout]"
      #assert_select "a[href=/users/alex]"
    end
    
  end
  
end