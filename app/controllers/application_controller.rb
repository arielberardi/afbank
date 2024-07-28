class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root_with_error

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name birth_date phone_number])
  end

  def redirect_to_root_with_error
    redirect_to authenticated_root_path, alert: I18n.t('errors.general')
  end
end
