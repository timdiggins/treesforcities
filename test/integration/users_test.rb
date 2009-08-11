require "#{File.dirname(__FILE__)}/../test_helper"

class UsersTest < ActionController::IntegrationTest
  
  context "when unlogged_in" do
    should "be able to see user" do
      get_ok "/users/alex"
      assert 'h1', /.*Alexander Kohlhofer.*/
    end
    
    should "have path with url" do
      alexpath = '/users/alex'
      opts = {:controller=>'users', :id=>'alex', :action=>'show'}
      assert_routing('/users/alex', opts)
      assert_generates('/users/alex', opts)
      assert_recognizes(opts, '/users/alex')
      assert_equal alexpath, user_path(users(:alex))
    end
    
  end
  
end