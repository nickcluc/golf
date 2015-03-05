class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    user_path(user)
  end

  def after_update_path_for(user)
    user_path(user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :cover_image, :profile_photo]
    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :cover_image, :profile_photo]
  end
end
