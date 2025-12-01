class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many  :events, class_name: "DailyEvent", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_weathers, class_name: "DailyWeather", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_horoscopes, class_name: "DailyHoroscope", foreign_key: "user_id", dependent: :destroy

  validates :text_time, presence: true
  validates :phone_number, format: { with: "^[0-9]{10}$" }
  validates :phone_number, uniqueness: { case_sensitive: false, message: "This phone number has already been registered. Please sign in." }
  validates :location, presence: true
  validates :birth_date, presence: true
end
