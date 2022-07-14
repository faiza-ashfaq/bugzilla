# frozen_string_literal: true

Rails.application.routes.draw do
  root 'projects#index'
  devise_for :users, controllers: {sessions: "sessions"}
  devise_for :managers
  devise_for :developers
  devise_for :qas
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
