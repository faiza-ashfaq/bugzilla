# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  devise_group :user, contains: %i[managers developers qa]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:username, :email, :password, :current_password)
    end
  end
end
