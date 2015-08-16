class ChangeExpireToNotNullInJobs < ActiveRecord::Migration
  def change
    change_column_null(:jobs, :expired, false, false)
  end
end
