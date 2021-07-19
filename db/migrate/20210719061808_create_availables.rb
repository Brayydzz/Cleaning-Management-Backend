class CreateAvailables < ActiveRecord::Migration[6.1]
  def change
    create_table :availables do |t|
      t.date :day
      t.references :user, null: false, foreign_key: true
      t.string :freedom

      t.timestamps
    end
  end
end
