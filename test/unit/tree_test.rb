require 'test_helper'

class TreeTest < ActiveSupport::TestCase
  
  context "Tree" do
    
    should "update own lot" do
      lot = lots(:one)
      assert lot.tree.nil?
      t = lot.build_tree
      t.save!
      lot.save!
      lot = Lot.find_by_id(lot.id)
      assert_equal t, lot.tree      
    end
  end
  
end
