class User < ApplicationRecord
  has_secure_password
  validates :password, confirmation: true
  
end
