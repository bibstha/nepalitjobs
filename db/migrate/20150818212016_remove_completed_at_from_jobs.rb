class RemoveCompletedAtFromJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :completed_at
  end
end
