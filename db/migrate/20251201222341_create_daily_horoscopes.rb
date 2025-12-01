class CreateDailyHoroscopes < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_horoscopes do |t|
      t.integer :user_id
      t.text :horoscope

      t.timestamps
    end
  end
end
