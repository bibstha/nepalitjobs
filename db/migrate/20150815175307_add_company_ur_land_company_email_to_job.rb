class AddCompanyUrLandCompanyEmailToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :company_url, :string
    add_column :jobs, :company_email, :string
  end
end
