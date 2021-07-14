class User < ApplicationRecord
  belongs_to :contact_information
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
end
