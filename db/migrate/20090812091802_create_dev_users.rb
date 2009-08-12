class CreateDevUsers < ActiveRecord::Migration
  def self.up
    User.create!(
          :login=>'admin', :name=>"Some Administrator", 
          :admin=>true, 
          :password=> 'adminpass',
          :password_confirmation=> 'adminpass',
          :email=>"admin@trees.com"
        )
    User.create!(
          :login=>'editor', :name=>"Some Editor", 
          :editor=>true, 
          :password=> 'editorpass',
          :password_confirmation=> 'editorpass',
          :email=>"editor@trees.com"
    )
    User.create!(
          :login=>'viz', :name=>"Some Visitor", 
          :editor=>true, 
          :password=> 'vizpass',
          :password_confirmation=> 'vizpass',
          :email=>"viz@trees.com"
    )
  end
  
  def self.down
    User.delete_all
  end
end
