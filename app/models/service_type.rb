class ServiceType < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :jobs
end
