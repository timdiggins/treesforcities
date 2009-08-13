class RemoveMoreUnusedFields < ActiveRecord::Migration
  def self.up
    remove_column :trees, :postcode
    remove_column :lots, :tree_id
  end

  def self.down
    add_column :trees, :postcode, :string
    add_column :lots, :tree_id, :integer
  end
end
