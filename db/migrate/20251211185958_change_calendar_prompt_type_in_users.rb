class ChangeCalendarPromptTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column(:users, :calendar_prompt, :text)
  end
end
