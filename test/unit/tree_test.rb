require 'test_helper'

class TreeTest < ActiveSupport::TestCase
  test "validates needs lot" do
    t = Tree.new()
    success = t.save
    assert !success, "should fail because lot_id is nil"
  end
end

