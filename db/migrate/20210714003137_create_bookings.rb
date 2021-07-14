class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :body
      t.string :phone_number
      t.references :service_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
