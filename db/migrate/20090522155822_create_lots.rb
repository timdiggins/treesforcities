class CreateLots < ActiveRecord::Migration
  def self.up
    create_table :lots do |t|
      t.string :project
      t.string :site_street
      t.string :exact_loc
      t.string :land_ownership
      t.string :borough
      t.string :ward
      t.string :postcode
      t.float :geo_x
      t.float :geo_y

      t.timestamps
    end
   end

  def self.down
    drop_table :lots
  end
end
