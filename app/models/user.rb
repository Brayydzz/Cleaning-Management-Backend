class User < ApplicationRecord
  belongs_to :contact_information
  has_many :jobs
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  def api_friendly
    return {
             id: id, email: email, is_admin: isAdmin,
           }
  end

  def serialize
    { user_data: { user: self.api_friendly,
                  contact_information: self.contact_information.api_friendly,
                  address: self.contact_information.address.api_friendly,
                  address_object: self.contact_information.address } }
  end
end
