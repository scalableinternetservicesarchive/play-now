# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user#index'
  get '/room', to: 'room#index'

  # resources :home, only: :index
end
