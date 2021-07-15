class Address < ApplicationRecord
  has_many :contact_information

  def api_friendly
    return {
             id: id, street_number: street_number, street_address: street_address, unit_number: unit_number, suburb: suburb, state: state, postcode: postcode,
           }
  end
end
