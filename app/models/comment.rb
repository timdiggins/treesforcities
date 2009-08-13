class Comment < ActiveRecord::Base
  belongs_to :lot
  belongs_to :user
end
