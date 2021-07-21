class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.text :url
      t.references :job, null: false, foreign_key: true
      t.string :public_id

      t.timestamps
    end
  end
end
