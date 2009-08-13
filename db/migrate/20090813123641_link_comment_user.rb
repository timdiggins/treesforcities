class LinkCommentUser < ActiveRecord::Migration
  def self.up
    add_column :comments, :user_id, :integer
    remove_column :comments, :author
  end

  def self.down
    remove_column :comments, :user_id
    add_column :comments, :author, :string
  end
end
