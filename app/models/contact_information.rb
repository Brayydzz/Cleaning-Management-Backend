class ContactInformation < ApplicationRecord
  has_one :address
  has_many :users
end
