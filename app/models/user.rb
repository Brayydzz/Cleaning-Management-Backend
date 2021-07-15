class User < ApplicationRecord
  belongs_to :contact_information
  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true

  def api_friendly
    return {
             id: id, email: email, is_admin: isAdmin,
           }
  end
end
