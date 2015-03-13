class Users::RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        if params[:user][:profile_photo].present?
          flash[:notice] = "Thanks for signing up! Now please set your profile picture!"
          render "crop"
        else
          respond_with resource, location: after_sign_up_path_for(resource)
        end
      end
    else
      clean_up_passwords resource
      render 'homes/index'
    end
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @user = User.find(current_user.id)
      successfully_updated = if account_update_params[:password].blank?
        params[:user].delete(:current_password)
        @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      else
        @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
      end

      if successfully_updated
        if params[:user][:profile_photo].present?
          render "crop"
        else
          set_flash_message :notice, :updated
          sign_in @user, :bypass => true
          redirect_to user_path(resource)
        end
      else
        render "edit"
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

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end
end
