class Lot < ActiveRecord::Base
  has_one :tree
  has_many :comments
end
