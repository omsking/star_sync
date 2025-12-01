class CreateDailyWeathers < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_weathers do |t|
      t.integer :temperature
      t.string :rain_percentage
      t.string :snow_percentage
      t.string :sun_percentage
      t.integer :user_id

      t.timestamps
    end
  end
end
