class Client < ApplicationRecord
  belongs_to :contact_information

  def serialize
    { client_data: {
      client: self,
      contact_information: self.contact_information.api_friendly,
      address: self.contact_information.address.api_friendly,
      address_object: self.contact_information.address,
    } }
  end
end
