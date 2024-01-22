class GroupUser < ApplicationRecord
  #下記の子を持つ
  belongs_to :user
  belongs_to :group
  
end
