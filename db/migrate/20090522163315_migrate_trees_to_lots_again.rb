class MigrateTreesToLotsAgain < ActiveRecord::Migration
  def self.up
    Lot.delete_all
    Tree.all.each do |tree|
      lot = Lot.new({
        :project => tree.project, 
        :site_street => tree.site_street,
        :exact_loc => tree.exact_loc, 
        :land_ownership => tree.land_ownership,
        :borough => tree.borough, 
        :ward => tree.ward
      })
      lot.tree = tree
      lot.save!
      tree.lot = lot
      tree.save!
    end
  end
  
  def self.down
  end
end
