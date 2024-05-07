class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Adds username and name fields on singup
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :avatar])
  end

end
