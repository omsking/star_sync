class ApplicationController < ActionController::Base
  skip_forgery_protection

  before_action :configure_permitted_parameters, { :if => :devise_controller? }

  def configure_permitted_parameters
    added_attrs = [:phone_number, :birth_date, :current_location, :birth_time, :text_time]

    devise_parameter_sanitizer.permit(:sign_up, :keys => added_attrs)
    devise_parameter_sanitizer.permit(:account_update, :keys => added_attrs)
  end

end
