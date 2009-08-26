class Lot < ActiveRecord::Base
  has_one :tree
  has_many :comments
end

class Tree < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  
end


class MergeLotsIntoTrees < ActiveRecord::Migration
  def self.up
    add_column :trees, :nearest_address, :string
    add_column :trees, :how_to_find, :string
    add_column :trees, :postcode, :string
    add_column :trees, :lat, :float
    add_column :trees, :lng, :float
    add_column :comments, :tree_id, :integer
    
    Lot.all.each do |lot|
      puts "lot: #{lot} (tree: #{lot.tree})"
      tree = lot.tree || Tree.new
      tree.nearest_address = lot.nearest_address
      tree.how_to_find = lot.how_to_find
      tree.postcode = lot.postcode
      tree.lat = lot.lat
      tree.lng = lot.lng
      tree.save!
      
      lot.comments.each do |c| 
        tree.comments << c
        c.save!
      end
    end
    
    remove_column :comments, :lot_id, :integer
    drop_table :lots
  end
  
  def self.down
    add_column :comments, :lot_id, :integer
    remove_column :comments, :tree_id, :integer
    
    create_table "lots", :force => true do |t|
      t.string   "nearest_address"
      t.string   "how_to_find"
      t.string   "postcode"
      t.float    "lat"
      t.float    "lng"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    remove_column :trees, :nearest_address
    remove_column :trees, :how_to_find
    remove_column :trees, :postcode
    remove_column :trees, :lat
    remove_column :trees, :lng
    
    
    
  end
end
