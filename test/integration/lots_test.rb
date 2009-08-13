require "#{File.dirname(__FILE__)}/../test_helper"

class LotsTest < ActionController::IntegrationTest
  
  context "generally" do
    should "be able to see list of lots" do
    get_ok '/lots'
  end
  
    should "be able to see a lot" do
      get_ok "/lots/#{lots(:one).id}"
  end
  

    should "be able to make new lot" do
      get_ok "/lots/new"
      fill_in :lot_nearest_address, :with => "5 Cowcross St, London"
      fill_in :postcode, :with => "EC1M 6DW"
      fill_in :lot_how_to_find, :with => "Slightly to the east of the door. Has a black tag on it"
      click_button
      assert_response_ok
      follow_redirect! while redirect?
    end
  end
  
end