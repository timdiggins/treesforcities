class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species do |t|
      t.string :common
      t.string :scientific

      t.timestamps
    end
  end

  def self.down
    drop_table :species
  end
end
