class RemoveStatusColumn < ActiveRecord::Migration[5.2]
  def change #this has to be done to normalize database
    remove_column :applications, :status
    add_column :applications, :submitted, :boolean, default: false
  end
end
