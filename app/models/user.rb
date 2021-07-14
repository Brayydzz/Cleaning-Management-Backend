class User < ApplicationRecord
  has_one :contact_information
  has_secure_password
end
