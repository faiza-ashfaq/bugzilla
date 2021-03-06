# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # GET /resource/sign_up
    def new
      build_resource
      yield resource if block_given?
      respond_with resource
    end

    # POST /resource
    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    def edit
      render :edit
    end

    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    private
    def sign_up_params
      if (params.has_key?(:developer))
        params.require(:developer)
      elsif (params.has_key?(:qa))
        params.require(:qa)
      elsif (params.has_key?(:manager))
        params.require(:manager)
      end.permit(:username, :email, :password, :password_confirmation)
    end

    def account_update_params
      if (params.has_key?(:developer))
        params.require(:developer)
      elsif (params.has_key?(:qa))
        params.require(:qa)
      elsif (params.has_key?(:manager))
        params.require(:manager)
      end.permit(:username, :email, :password, :password_confirmation, :current_password)
    end
  end
end
