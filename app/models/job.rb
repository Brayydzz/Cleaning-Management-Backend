class Job < ApplicationRecord
  belongs_to :address
  belongs_to :service_type
  belongs_to :client
  belongs_to :user, optional: true
  has_many :notes, dependent: :destroy

  def api_friendly
    return {
             id: id, due_data: due_date, time_in: time_in, time_out: time_out, reoccuring: reoccuring,
             reoccuring_length: reoccuring_length,
           }
  end

  def serialize
    { job_data: { job: self.api_friendly,
                 address: self.address.api_friendly,
                 user: self.user ? self.user.serialize : "User unassigned",
                 service_type: self.service_type,
                 client: self.client.serialize,
                 address_object: self.address,
                 notes: self.notes } }
  end
end
