class Like < ApplicationRecord

  belongs_to :user
  belongs_to :outfit

  def self.of(user)
    self.all.select { |like| like.user_id == user.id }
  end

  def self.liked?(user, outfit)
    self.of(user).find { |like| like.outfit_id == outfit.id }
  end

end
