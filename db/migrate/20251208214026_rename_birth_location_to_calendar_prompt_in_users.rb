class RenameBirthLocationToCalendarPromptInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :birth_location, :calendar_prompt
    change_column :users, :calendar_prompt, :string
  end
end
