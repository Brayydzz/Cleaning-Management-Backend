class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.references :address, null: false, foreign_key: true
      t.references :service_type, null: false, foreign_key: true
      t.datetime :due_date
      t.references :client, null: false, foreign_key: true
      t.datetime :time_in
      t.datetime :time_out
      t.boolean :reoccuring
      t.integer :reoccuring_length
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
