class Tree < ActiveRecord::Base
  has_one :lot
  
  validates_associated :lot
  
  def to_s
    "Tree ##{(tree_no)}"
  end
end
