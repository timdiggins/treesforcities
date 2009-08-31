class Species < ActiveRecord::Base
  has_one :image, :class_name => 'SpeciesImage'
  accepts_nested_attributes_for :image
  
  def to_s
    "#{common} (#{scientific})"
  end
end
