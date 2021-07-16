class Address < ApplicationRecord
  has_many :contact_information

  validates :street_address, :street_number, :postcode, :suburb, :state, :postcode, presence: true

  def api_friendly
    return {
             id: id, street_number: street_number, street_address: street_address, unit_number: unit_number, suburb: suburb, state: state, postcode: postcode,
           }
  end
end
