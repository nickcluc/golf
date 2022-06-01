class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    user_path(user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :first_name,
      :last_name,
      :cover_image,
      :profile_photo,
      :profile_photo_crop_x,
      :profile_photo_crop_y,
      :profile_photo_crop_w,
      :profile_photo_crop_h
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :first_name,
      :last_name,
      :cover_image,
      :profile_photo,
      :profile_photo_crop_x,
      :profile_photo_crop_y,
      :profile_photo_crop_w,
      :profile_photo_crop_h
    ])
  end
end
