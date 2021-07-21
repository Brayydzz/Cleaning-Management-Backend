class Note < ApplicationRecord
  belongs_to :job, optional: true, dependent: :destroy
  belongs_to :client, optional: true, dependent: :destroy
end
