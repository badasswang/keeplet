class RemoveActiveFromSpaces < ActiveRecord::Migration
  def change
    remove_column :spaces, :active, :boolean
  end
end
