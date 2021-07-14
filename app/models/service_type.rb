class ServiceType < ApplicationRecord
  has_many :bookings, dependent: :destroy
end
