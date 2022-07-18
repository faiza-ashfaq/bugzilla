# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      run_s = super
      sign_in(resource.type.underscore, resource.type.constantize.send(:find, resource.id)) unless resource.type.nil?
      run_s
    end
  end
end
