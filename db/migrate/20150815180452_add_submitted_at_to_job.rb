class AddSubmittedAtToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :submitted_at, :datetime
  end
end
