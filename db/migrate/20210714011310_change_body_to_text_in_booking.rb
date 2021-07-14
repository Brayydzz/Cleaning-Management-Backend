class ChangeBodyToTextInBooking < ActiveRecord::Migration[6.1]
  def change
    change_column :bookings, :body, :text
  end
end
