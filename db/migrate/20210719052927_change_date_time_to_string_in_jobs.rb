class ChangeDateTimeToStringInJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :due_date, :string
  end
end
