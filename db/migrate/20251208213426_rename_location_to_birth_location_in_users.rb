class RenameLocationToBirthLocationInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :location, :current_location
  end
end
