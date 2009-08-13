class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :editor, :boolean
    add_column :users, :admin, :boolean
  end

  def self.down
    remove_column :users, :admin
    remove_column :users, :editor
  end
end
