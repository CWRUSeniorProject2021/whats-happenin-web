class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?


  layout :default_layout

  def default_layout
    return "application_layout"
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :first_name, :last_name])
  end
end
