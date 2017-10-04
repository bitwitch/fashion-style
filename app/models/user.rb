class User < ApplicationRecord
  has_many :outfits
  has_secure_password
  validates :password, confirmation: true
  
  has_many :friendships
  has_many :friends, class_name: 'User', through: :friendships, foreign_key: :friend_id 



  def friend(user)
    Friendship.create(user_id: self.id, friend_id: user.id)
    Friendship.create(user_id: user.id, friend_id: self.id)
  end 

end
