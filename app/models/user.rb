class User < ActiveRecord::Base
  validates :username, presence: true

  has_secure_password
  validates :password, length: { minimum: 5 }
end
