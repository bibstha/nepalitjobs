class AddApplyProcessToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :apply_process, :text
  end
end
