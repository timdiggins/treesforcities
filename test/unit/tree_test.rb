require 'test_helper'

class TreeTest < ActiveSupport::TestCase
  
  context "generally" do
    
    should "be able to autolookup on create" do
      tree = Tree.new(:nearest_address => "5 Cowcross St, London",
       :postcode => "EC1M 6DW",
      :how_to_find => "Slightly to the east of the door. Has a black tag on it"
      )
      tree.save!
      expect_lat = 51.52064
      expect_lng = -0.102063
      assert_in_delta expect_lat, tree.lat, 0.0001
      assert_in_delta expect_lng, tree.lng, 0.0001
    end
  end
  
  
end
