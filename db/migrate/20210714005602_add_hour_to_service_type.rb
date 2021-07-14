class AddHourToServiceType < ActiveRecord::Migration[6.1]
  def change
    add_column :service_types, :hours_needed, :float
  end
end
