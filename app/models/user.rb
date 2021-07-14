class User < ApplicationRecord
  has_one :contact_information
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
end
