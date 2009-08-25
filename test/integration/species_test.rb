require "#{File.dirname(__FILE__)}/../test_helper"

module UnauthorizedUser
  def self.included(klass)
    klass.class_eval do  
      should "be able to see list" do
        get_ok '/species'
      end
      
      should "be able to see a species" do
        get_ok "/species/#{species(:birch).id}"
      end
      
      should "be able to view a species" do
        get_ok "/species/#{species(:birch).id}"
      end
      
      should "not be able to make new species" do
        assert_can_make_species false
      end
      
      should "be not able to edit existing species" do
        assert_can_edit_species false
      end
    end 
  end
end

class SpeciesTest < ActionController::IntegrationTest
  
  context "Unlogged in user" do
    include UnauthorizedUser
  end
  
  context "Logged in user" do
    setup do
      login!('quentin')
    end
    include UnauthorizedUser
  end
  
  
  context "Logged in editor" do
    setup do
      login!('an_editor')
    end
    
    should "be able to make species" do 
      assert_can_make_species
    end
    should "be able to edit existing species" do
      assert_can_edit_species 
    end
  end
  
  
  
  def assert_can_make_species can=true
    get_ok '/species'
    assert_has_linkhref can, '/species/new'
    
    get "/species/new"
    if !can
      assert_response_denied
      return
    end
    assert_response_ok
    fill_in :common, :with => "Oak"
    fill_in :scientific, :with => "Quercus Ruber"
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select 'p', /Oak/
    assert_select 'p', /Quercus Ruber/
  end
  
  def assert_can_edit_species can=true
    species = species(:birch)
    get_ok "/species/#{species.id}"
    url = "/species/#{species.id}/edit"
    assert_has_linkhref can, url
    get url
    if !can
      assert_response_denied
      return
    end
    fill_in :common, :with => "Brunette Birch"
    fill_in :scientific, :with => "birchus brunettus"
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select 'p', /Brunette/
    assert_select 'p', /brunettus/
  end
end