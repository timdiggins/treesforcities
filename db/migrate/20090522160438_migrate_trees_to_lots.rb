class MigrateTreesToLots < ActiveRecord::Migration
  def self.up
     Tree.all.each do |tree|
      lot = Lot.new({
        :project => tree.project, 
        :site_street => tree.site_street,
        :exact_loc => tree.exact_loc, 
        :land_ownership => tree.land_ownership,
        :borough => tree.borough, 
        :ward => tree.ward
        })
      lot.save!
    end
  end

  def self.down
    Lot.delete_all!
  end
end
