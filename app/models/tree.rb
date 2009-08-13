class Tree < ActiveRecord::Base
  has_one :lot
  
  validates_associated :lot
  
end
