class ContactInformation < ApplicationRecord
  belongs_to :address
  has_many :users

  validates :phone_number, :email, :first_name, :last_name, presence: true

  def api_friendly
    {
      id: id, phone_number: phone_number, first_name: first_name, last_name: last_name, email: email
    }
  end
end
