# == Schema Information
#
# Table name: daily_weathers
#
#  id              :bigint           not null, primary key
#  rain_percentage :string
#  snow_percentage :string
#  sun_percentage  :string
#  temperature     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class DailyWeather < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
