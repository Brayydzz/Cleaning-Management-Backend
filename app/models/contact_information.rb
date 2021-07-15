class ContactInformation < ApplicationRecord
  belongs_to :address
  has_many :users

  def api_friendly
    return {
             id: id, phone_number: phone_number, first_name: first_name, last_name: last_name, email: email,
           }
  end
end
