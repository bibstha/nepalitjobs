class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company_name
      t.string :company_info
      t.text :description
      t.boolean :expired

      t.timestamps
    end
  end
end
