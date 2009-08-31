class AddSpeciesToTrees < ActiveRecord::Migration
  def self.up
    add_column :trees, :species_id, :integer
  end

  def self.down
    remove_column :trees, :species_id
  end
end
