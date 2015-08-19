class AddEmailStatusToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :email_status, :string
  end
end
