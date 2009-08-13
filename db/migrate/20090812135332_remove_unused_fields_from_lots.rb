class RemoveUnusedFieldsFromLots < ActiveRecord::Migration
  def self.up
    
    remove_column :lots, :project
    remove_column :lots, :land_ownership
    remove_column :lots, :borough
    remove_column :lots, :ward
    
    rename_column :lots, :site_street, :nearest_address
    rename_column :lots, :exact_loc, :how_to_find
    
    rename_column :lots, :geo_x, :lat
    rename_column :lots, :geo_y, :lng
    
  end
  
  def self.down
    add_column :lots, :project, :string
    add_column :lots, :land_ownership, :string
    add_column :lots, :borough, :string
    
    rename_column :lots, :nearest_address, :site_street
    rename_column :lots, :how_to_find, :exact_loc
    
    rename_column :lots, :lat, :geo_x
    rename_column :lots, :lng, :geo_y
  end
end
