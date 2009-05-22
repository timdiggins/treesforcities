class RemoveUnneededTreeFields < ActiveRecord::Migration
  def self.up
    remove_column :trees, :priority
    remove_column :trees, :action
  end

  def self.down
    add_column :trees, :priority, :string
    add_column :trees, :action, :string
  end
end
