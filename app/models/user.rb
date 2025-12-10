# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birth_date             :date
#  birth_location         :string
#  birth_time             :time
#  calendar_prompt        :string
#  current_location       :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  google_access_token    :string
#  google_refresh_token   :string
#  phone_number           :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  text_opt_in            :boolean          default(FALSE)
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider_and_uid      (provider,uid) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # encrypts :google_access_token, :google_refresh_token # TODO: configure Active Record Encryption keys
  
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable,
          :omniauthable,
          :omniauth_providers => [:google_oauth2]

  has_many  :events, class_name: "DailyEvent", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_weathers, class_name: "DailyWeather", foreign_key: "user_id", dependent: :destroy
  has_many  :daily_horoscopes, class_name: "DailyHoroscope", foreign_key: "user_id", dependent: :destroy

 # validates :text_time, presence: true
 # validates :phone_number, format: { with: /\A[0-9]{10}\z/ }
 # validates :phone_number, uniqueness: { case_sensitive: false, message: "This phone number has already been registered. Please sign in." }
 # validates :current_location, presence: true
 # validates :birth_date, presence: true

  # Google Calendar Oauth Setup  
  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)
    user ||= find_by(email: auth.info.email)
    user ||= new(
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )

    user.provider = auth.provider
    user.uid = auth.uid
    user.google_access_token = auth.credentials.token
    user.google_refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token.present?
    user.save
    user
  end
end
