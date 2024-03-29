class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?

  add_flash_types :danger, :info, :warning, :success

  def user_not_authorized
    flash[:danger] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def set_current_user
    Current.user = current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end
end
