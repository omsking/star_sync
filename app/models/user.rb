# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birth_date             :date
#  birth_location         :string
#  birth_time             :time
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  location               :string
#  phone_number           :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  text_time              :time
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :events, class_name: "DailyEvent", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_weathers, class_name: "DailyWeather", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_horoscopes, class_name: "DailyHoroscope", foreign_key: "user_id", dependent: :destroy

  validates :text_time, presence: true
  validates :phone_number, format: { with: /\A[0-9]{10}\z/ }
  validates :phone_number, uniqueness: { case_sensitive: false, message: "This phone number has already been registered. Please sign in." }
  validates :location, presence: true
  validates :birth_date, presence: true
end
