class Lot < ActiveRecord::Base
  has_one :tree
  has_many :comments
  
  validates_presence_of :lat, :lng
  
  acts_as_mappable 
  before_validation_on_create :geocode_address
  
  def geocode_address
    return true if !self.lat.nil? && !self.lat.nil?
    if self.nearest_address.blank? && self.postcode.blank?
      return true
    end
    address = "#{self.nearest_address}, #{self.postcode}, UK"
    geo = GeoKit::Geocoders::MultiGeocoder.geocode(address)
    self.lat, self.lng = geo.lat, geo.lng
  end
  
  def to_s
    return "Empty lot ##{id}" if tree.nil?
    "Tree ##{tree.tree_no}"
  end
end
