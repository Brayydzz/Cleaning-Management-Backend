class CreateContactInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_informations do |t|
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
