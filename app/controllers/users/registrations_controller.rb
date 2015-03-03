class Users::RegistrationsController < Devise::RegistrationsController
  # def create
  #   @user = User.new(sign_up_params)
  #   if resource.save
  #     flash[:notice] = "Welcome to Wagglr!"
  #     redirect_to root_path
  #   else
  #
  #   end
  # end

  def create
  build_resource(sign_up_params)

  resource.save
  yield resource if block_given?
  if resource.persisted?
    if resource.active_for_authentication?
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  else
    clean_up_passwords resource
    render 'homes/index'
  end
end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

  private

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
