class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :note
      t.references :job, foreign_key: true
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
