require "#{File.dirname(__FILE__)}/../test_helper"

module AnyoneShould
  def self.included(klass)
    klass.class_eval do  
      should "be able to see list of trees" do
        get_ok '/trees'
      end
            
      should "be able to see a tree" do
        get_ok "/trees/#{trees(:one).id}"
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
      
      should "not be able to make new tree" do
        assert_can_make_tree false
      end
      
      should "not be able to edit tree details" do
        assert_can_edit_tree_details false
      end
      
      should "not be able to edit location" do
        assert_can_edit_location false
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


class TreesTest < ActionController::IntegrationTest
  
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
    should "be able to make new tree" do
      assert_can_make_tree 
    end
    
    should "be able to edit tree details" do
      assert_can_edit_tree_details 
    end
      
    should "be able to edit location" do
      assert_can_edit_location 
    end
      
  end
  
  
  def assert_can_make_lot can=true
    get_ok "/trees"
    url = "/trees/new"
        assert_has_linkhref can, url
    
    get url
    if !can
      assert_response_denied
      return
    end
    assert_response_ok
    fill_in_location_data
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select 'p', /.*EC1M 6DW.*/
  end
  
  
  def assert_can_make_tree can=true
    get_ok "/trees"
    url = "/trees/new"
    assert_has_linkhref can, url
    get url
    if !can
      assert_response_denied
      return
    end
        assert_response_ok
    fill_in_location_data
    fill_in_tree_data    
    click_button
    assert_response_ok
    follow_redirect! while redirect?
  end

  def assert_can_edit_tree_details can=true
    tree_id = trees(:one).id
    get_ok "/trees/#{tree_id}"
    url = "/trees/#{tree_id}/edit"
    assert_has_linkhref can, url
    get url
    if !can
      assert_response_denied
      return
    end
    assert_response_ok
    fill_in_tree_data    
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    view
    assert_select "h2", /tr423423/, :count=>1
  end
  
  def assert_can_edit_location can=true
    tree_id = trees(:one).id
    get_ok "/trees/#{tree_id}"
    url = "/trees/#{tree_id}/edit_location"
    assert_has_linkhref can, url
    get url
    if !can
      assert_response_denied
      return
    end
    assert_response_ok
    fill_in_location_data    
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select "p", /5 Cowcross St/, :count=>1
  end

  
  def fill_in_location_data
    fill_in(:tree_nearest_address, {:with => "5 Cowcross St, London"})
    fill_in(:postcode, {:with => "EC1M 6DW"})
    fill_in(:tree_how_to_find, {:with => "Slightly to the east of the door. Has a black tag on it"})
  end
  
  def fill_in_tree_data
    fill_in(:tree_tree_no, {:with => "tr423423"})
    fill_in(:tree_date_planted_1i, {:with => "2009"})
    fill_in(:tree_date_planted_1i, {:with => "August"})
    fill_in(:tree_date_planted_1i, {:with => "1"})
  end
  
  
  def assert_can_make_comment can=true
    #initial_size = Event.all.size
    get_ok "/trees/#{trees(:one).id}"
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