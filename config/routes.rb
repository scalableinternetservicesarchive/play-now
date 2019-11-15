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
  patch '/room/:id', to: 'room#forward'
  patch '/room.:id', to: 'room#change'
  patch '/room/:id/seek', to: 'room#seek'
  patch '/room/:id/stop', to: 'room#stop'
  patch '/room/:id/play', to: 'room#play'

  mount ActionCable.server => '/cable'
  # resources :home, only: :index
end
