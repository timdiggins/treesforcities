class Comment < ActiveRecord::Base
  belongs_to :tree
  belongs_to :user
end
