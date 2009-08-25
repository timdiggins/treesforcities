require "#{File.dirname(__FILE__)}/../test_helper"

module AnyoneShould
  def self.included(klass)
    klass.class_eval do  
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
    end
  end
end

module UnauthorizedShouldnt
  def self.included(klass)
    klass.class_eval do  
      should "not be able to make new lot" do
        assert_can_make_lot false
      end
      
      should "not be able to make new tree on existing lot" do
        assert_can_make_tree false
      end
      
    end  
  end
end

module LoggedinShould
  def self.included(klass)
    klass.class_eval do  
      should "be able to make a comment" do
        assert_can_make_comment
      end
      
    end  
  end
end


class LotsTest < ActionController::IntegrationTest
  
  context "Unlogged in user" do
    
    include AnyoneShould    
    include UnauthorizedShouldnt
    
    should "not be able to make a comment" do
      assert_can_make_comment false
    end
  end
  
  
  context "Logged in user" do
    setup do
      login!('quentin')
    end
    
    include AnyoneShould    
    include LoggedinShould
    include UnauthorizedShouldnt
    
  end
  
  
  context "Logged in editor" do
    setup do
      login!('an_editor')
    end
    
    include AnyoneShould    
    include LoggedinShould
    
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
  
  def assert_can_make_comment can=true
    #initial_size = Event.all.size
    get_ok "/lots/#{lots(:one).id}"
    assert_select ".comment a[href=/users/#{@logged_in.login}]", :count=>0 if can
    if !can
      assert_select 'form', :count=>0
      return
    end
    
    comment = "Some ideas I had about this lovely thing"
    fill_in :comment_text, :with=> comment
    click_button
    follow_redirect!
    assert_response_ok
    assert_select 'p', /.*#{comment}.*/
    assert_has_linkhref true, "/users/#{@logged_in.login}"
    assert_select ".comment a[href=/users/#{@logged_in.login}]", :min=>1
    #assert initial_size+1, Event.all.size
  end
  
end