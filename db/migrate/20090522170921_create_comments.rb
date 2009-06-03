class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :lot_id
      t.text :text
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
