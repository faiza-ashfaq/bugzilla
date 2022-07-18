# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  devise_group :user, contains: %i[managers developers qa]
  def pundit_user
    current_manager || current_developer || current_qa
  end
end
