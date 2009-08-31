require "#{File.dirname(__FILE__)}/../test_helper"


module AnyoneShould
  def self.included(klass)
    klass.class_eval do  
      should "be able to see list" do
        get_ok '/species'
      end
      
      should "be able to see a species" do
        get_ok "/species/#{species(:birch).id}"
      end
      should "be able to see a species with no avatar" do
        get_ok "/species/#{species(:beech).id}"
      end
    end
  end
end
module UnauthorizedShouldnt
  def self.included(klass)
    klass.class_eval do  
      
      should "not be able to make new species" do
        assert_can_make_species false
      end
      
      should "be not able to edit existing species" do
        assert_can_edit_species false
      end
    end 
  end
end

class SpeciesPageTest < ActionController::IntegrationTest
  FIXTURES_DIR = "#{File.dirname(__FILE__)}/../fixtures/files/"
  
  context "Unlogged in user" do
    include AnyoneShould
    include UnauthorizedShouldnt
  end
  
  context "Logged in user" do
    setup do
      login!('quentin')
    end
    include AnyoneShould
    include UnauthorizedShouldnt
  end
  
  
  context "Logged in editor" do
    setup do
      login!('an_editor')
    end
    include AnyoneShould
    
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
    attach_file :species_image_attributes_uploaded_data, "#{FIXTURES_DIR}/beech.png", "image/png"
    click_button
    assert_response_ok
    follow_redirect! while redirect?
    assert_select 'p', /Oak/
    assert_select 'p', /Quercus Ruber/
    assert_select 'img[src*=beech]', :count=>1
  end
  
  def assert_can_edit_species can=true
    [species(:birch), species(:beech)].each do |species|
      get_ok "/species/#{species.id}"
      edit_url = "/species/#{species.id}/edit"
      assert_has_linkhref can, edit_url
      get edit_url
      if !can
        assert_response_denied
        return
      end
      assert_response_ok
      fill_in :common, :with => "Brunette Birch"
      fill_in :scientific, :with => "birchus brunettus"
      attach_file :species_image_attributes_uploaded_data, "#{FIXTURES_DIR}/oak_tree.jpg", "image/jpg"
      click_button
      assert_response_ok
      follow_redirect! while redirect?
      assert_select 'p', /Brunette/
      assert_select 'p', /brunettus/
      assert_select 'img[src*=oak]', :count=>1
      view species.common.downcase.split(' ')[0]
    end
  end
end