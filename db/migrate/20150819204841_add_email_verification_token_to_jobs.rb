class AddEmailVerificationTokenToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :email_verification_token, :string
  end
end
