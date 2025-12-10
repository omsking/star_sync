class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    return resource.update_without_password(params)
  end
end
