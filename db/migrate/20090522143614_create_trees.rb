class CreateTrees < ActiveRecord::Migration
  def self.up
    create_table :trees do |t|
      t.string :tree_no
      t.date :date_planted
      t.string :priority
      t.string :action
      t.string :project
      t.string :site_street
      t.string :exact_loc
      t.string :land_ownership
      t.string :borough
      t.string :ward
      t.string :species
      t.string :common_name
      t.string :postcode
      t.float :geo_x
      t.float :geo_y

      t.timestamps
    end
  end

  def self.down
    drop_table :trees
  end
end
