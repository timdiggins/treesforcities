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
      assert_select "a[href=/users/alex]"
    end
    
    should "be able to signup as a user" do
      get('/signup')
      fill_in :login, :with=>'my_lovely_name'
      fill_in :name, :with=>'My Lovely Name'
      fill_in :email, :with=>'some@somewhere.com'
      fill_in :password, :with=> 'Parsewerd'
      fill_in 'user[password_confirmation]', :with=> 'Parsewerd'
      click_button
      assert_response_ok
      follow_redirect! while redirect?
      assert_select "a[href=/logout]"
      assert_login_doesnt_exist 'my lovely name'
      assert_login_doesnt_exist 'my lovely name'
      assert_login_exists 'my_lovely_name'
      assert_select "a[href=/users/my_lovely_name]"
    end
  end
  def assert_login_doesnt_exist login_name
    assert User.find_by_login(login_name).nil?, "expected user (login='#{login_name}') not to exist, but does"
  end
  def assert_login_exists login_name
    assert !User.find_by_login(login_name).nil?, "expected user (login='#{login_name}') not to exist, but doesn't"
  end
end