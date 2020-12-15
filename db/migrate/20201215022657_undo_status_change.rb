class UndoStatusChange < ActiveRecord::Migration[5.2]
  def change
    remove_column :application_pets, :status
    add_column :application_pets, :status, :string
  end
end
