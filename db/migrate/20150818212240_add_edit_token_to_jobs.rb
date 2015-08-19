class AddEditTokenToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :edit_token, :string
  end
end
