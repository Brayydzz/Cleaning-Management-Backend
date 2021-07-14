class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street_number, null: false
      t.string :street_address, null: false
      t.string :unit_number
      t.string :suburb, null: false
      t.string :state, null: false
      t.string :postcode, null: false

      t.timestamps
    end
  end
end
