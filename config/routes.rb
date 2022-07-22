# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_for :managers, controllers: { registrations: 'users/registrations' }
  devise_for :developers, controllers: { registrations: 'users/registrations' }
  devise_for :qas, controllers: { registrations: 'users/registrations' }
  resources :projects do
    resources :bugs do
      member do
        post :assign_dev
        post :resolve
      end
      collection do
        get 'update_status'
      end
    end
  end
  get '/*path', to: 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
