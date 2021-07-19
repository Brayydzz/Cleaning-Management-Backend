class Address < ApplicationRecord
  has_many :contact_information
  has_many :jobs

  validates :street_address, :street_number, :postcode, :suburb, :state, :postcode, presence: true

  def api_friendly
    if unit_number
      return "#{unit_number} / #{street_number} #{street_address}, #{suburb}, #{postcode}, #{state}"
    else
      return "#{street_number}, #{street_address}, #{suburb}, #{postcode}, #{state}"
    end
  end
end
