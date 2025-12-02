# == Schema Information
#
# Table name: daily_events
#
#  id         :bigint           not null, primary key
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class DailyEvent < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
end
