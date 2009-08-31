class CreateSpeciesImages < ActiveRecord::Migration
  def self.up
    create_table :species_images do |t|
      t.belongs_to :species
      t.string :content_type, :filename, :thumbnail
      t.integer :size, :width, :height, :parent_id

      t.timestamps
    end
  end

  def self.down
    drop_table :species_images
  end
end
