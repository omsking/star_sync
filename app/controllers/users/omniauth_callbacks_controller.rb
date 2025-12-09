class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    auth = request.env.fetch("omniauth.auth")

    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect(@user)
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session.store("devise.google_data", auth.except(:extra))
      redirect_to("/", :alert => "Something went wrong.")
    end
  end
end
