# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user#index'
  get '/room', to: 'room#index'
  post '/', to: 'user#create'

  # resources :home, only: :index
end
