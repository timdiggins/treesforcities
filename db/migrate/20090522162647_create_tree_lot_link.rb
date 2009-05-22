class CreateTreeLotLink < ActiveRecord::Migration
  def self.up
    add_column :lots, :tree_id, :integer
    add_column :trees, :lot_id, :integer
  end
  
  def self.down
    remove_column :lots, :tree_id 
    remove_column :trees, :lot_id
  end
end
