require "#{File.dirname(__FILE__)}/../test_helper"

class LotsTest < ActionController::IntegrationTest
  
  context "Unlogged in user" do
    
    should "be able to see list of lots" do
      get_ok '/lots'
    end
    
    should "be able to view index of trees" do
      get_ok "/trees"
    end
    
    should "be able to see a lot" do
      get_ok "/lots/#{lots(:one).id}"
    end
    
    should "be able to view a tree" do
      get_ok "/trees/#{trees(:one).id}"
    end
    
    
    should "not be able to make new lot" do
      assert_can_make_lot false
    end
    
    should "be not able to make new tree on existing lot" do
      assert_can_make_tree false
    end
  end
  
  
  context "Logged in user" do
    setup do
      login!('quentin')
    end
    
    should "not be able to make lot" do 
      assert_can_make_lot false
    end
    should "be not able to make new tree on existing lot" do
      assert_can_make_tree false
    end
    
    should "be able to make a comment" do
      #initial_size = Event.all.size
      get_ok "/lots/#{lots(:one).id}"
      assert_select '.comment a[href=/users/quentin]', :count=>0
      comment = "Some ideas I had about this lovely thing"
view
fill_in :comment_text, :with=> comment
      click_button
      follow_redirect!
      assert_response_ok
      assert_select 'p', /.*#{comment}.*/
      assert_has_linkhref true, '/users/quentin'
      assert_select '.comment a[href=/users/quentin]', :min=>1
      #assert initial_size+1, Event.all.size
    end
  end
  
  
  context "Logged in editor" do
    setup do
      login!('an_editor')
    end
    
    should "be able to make lot" do 
      assert_can_make_lot
    end
    should "be able to make new tree on existing lot" do
      assert_can_make_tree 
    end
  end
  
  
  
  def assert_can_make_lot can=true
    get_ok '/lots'
    assert_has_linkhref can, '/lots/new'
    
    get "/lots/new"
    if !can
      assert_response_denied
      return
    end
    assert_response_ok
    fill_in :lot_nearest_address, :with => "5 Cowcross St, London"
    fill_in :postcode, :with => "EC1M 6DW"
    fill_in :lot_how_to_find, :with => "Slightly to the east of the door. Has a black tag on it"
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select 'p', /.*EC1M 6DW.*/
  end
  
  def assert_can_make_tree can=true
    lot = Lot.find_by_id(lots(:one).id)
    get_ok "/lots/#{lot.id}"
    url = "/trees/new?lot_id=#{lot.id}"
    assert_has_linkhref can, url
    get url
    if !can
      assert_response_denied
      return
    end
    fill_in :tree_tree_no, :with => "tr423423"
    fill_in :tree_date_planted_1i, :with => "2009"
    fill_in :tree_date_planted_1i, :with => "August"
    fill_in :tree_date_planted_1i, :with => "1"
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    
  end
  
  
end