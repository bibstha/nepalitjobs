class RemoveCompanyInfoFromJob < ActiveRecord::Migration
  def change
    remove_column :jobs, :company_info
  end
end
