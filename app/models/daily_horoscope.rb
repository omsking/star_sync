# == Schema Information
#
# Table name: daily_horoscopes
#
#  id         :bigint           not null, primary key
#  horoscope  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class DailyHoroscope < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
