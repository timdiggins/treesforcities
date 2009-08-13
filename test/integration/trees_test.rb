require "#{File.dirname(__FILE__)}/../test_helper"

class TreesTest < ActionController::IntegrationTest
  
  context "generally" do
    should "be able to view index of trees" do
      get_ok "/trees"
    end
    
    should "be able to view a tree" do
      get_ok "/trees/#{trees(:one).id}"
    end
    
    should "be able to make new tree on existing lot" do
      lot = Lot.find_by_id(lots(:one).id)
      puts "lot=#{lot}"
      url = "/trees/new?lot_id=#{lots(:one).id}"
      puts url 
      get_ok url
      fill_in :tree_tree_no, :with => "tr423423"
      fill_in :tree_date_planted_1i, :with => "2009"
      fill_in :tree_date_planted_1i, :with => "August"
      fill_in :tree_date_planted_1i, :with => "1"
      click_button
      assert_response_ok
      follow_redirect! while redirect?
    end
  end
  
end