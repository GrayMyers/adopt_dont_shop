class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :address
      t.string :applicant
      t.string :description
      t.string :status
      t.timestamps
    end
  end
end
