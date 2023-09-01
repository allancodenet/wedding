# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  layout "user"
  # def after_sign_in_path_for(resource)
  #   if resource.role == "provider"
  #     providers_path
  #   elsif resource.role == "client"
  #     client_path(current_user)
  #   else
  #     root_path # Or any other default path if the role is not present or unknown
  #   end
  # end

  def after_sign_out_path_for(resource)
    user_session_path
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
