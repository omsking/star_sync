class RenameBirthLocation2ToBirthLocationInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :birth_location2, :birth_location
  end
end
