class Tree < ActiveRecord::Base
  has_one :lot

  def validate  
    if lot_id.nil?
      errors.add(:lot_id, "is missing")
    end
  end
end
