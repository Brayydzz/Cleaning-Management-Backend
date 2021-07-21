class Note < ApplicationRecord
  belongs_to :job, optional: true
  belongs_to :client, optional: true
end
