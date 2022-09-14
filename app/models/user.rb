class User < ApplicationRecord
  # パスワードをハッシュ化する(gem 'bcrypt')
  has_secure_password
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
