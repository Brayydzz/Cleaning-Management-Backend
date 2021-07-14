class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.references :contact_information, null: false, foreign_key: true
      t.boolean :isAdmin

      t.timestamps
    end
  end
end
