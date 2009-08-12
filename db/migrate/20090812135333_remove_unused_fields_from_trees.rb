class RemoveUnusedFieldsFromTrees < ActiveRecord::Migration
  def self.up
    remove_column :trees, :project
    remove_column :trees, :land_ownership
    remove_column :trees, :borough
    remove_column :trees, :ward
    remove_column :trees, :species
    remove_column :trees, :common_name
    remove_column :trees, :site_street
    remove_column :trees, :exact_loc
    remove_column :trees, :geo_x
    remove_column :trees, :geo_y
    
  end
  
  def self.down
    add_column :trees, :project, :string
    add_column :trees, :land_ownership, :string
    add_column :trees, :borough, :string
    add_column :trees, :site_street, :string
    add_column :trees, :exact_loc, :string
    add_column :trees, :geo_x, :string
    add_column :trees, :geo_y, :string
    add_column :trees, :ward, :string
    add_column :trees, :species, :string
    add_column :trees, :common_name, :string    
  end
end
