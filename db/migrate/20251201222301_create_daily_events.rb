class CreateDailyEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_events do |t|
      t.string :color
      t.integer :user_id

      t.timestamps
    end
  end
end
