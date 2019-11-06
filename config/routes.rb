# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user#index'
  post '/', to: 'user#create'
  get '/room', to: 'room#index'
  get '/room/create', to: 'room#create'
  post '/room/create', to: 'room#make'
  get '/room/join', to: 'room#join'
  get '/room/:id', to: 'room#show'
  delete '/room/:id', to: 'room#destroy'
  post '/room/:id', to: 'room#increment'

  mount ActionCable.server => '/cable'
  # resources :home, only: :index
end
