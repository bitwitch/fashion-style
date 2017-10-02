class User < ApplicationRecord
  has_many :outfits
  has_secure_password
  validates :password, confirmation: true
  
end
