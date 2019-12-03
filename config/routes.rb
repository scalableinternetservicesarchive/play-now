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
  delete '/room/delete/all', to: 'room#destroy_all'
  post '/room/:id', to: 'room#increment'
  patch '/room/:id', to: 'room#forward'
  patch '/room.:id', to: 'room#change'
  patch '/room/:id/seek', to: 'room#seek'
  patch '/room/:id/stop', to: 'room#stop'
  patch '/room/:id/play', to: 'room#play'
  patch '/room/:id/pause', to: 'room#pause'

  get '/room/:id/state', to: 'room#state'
  patch '/room/:id/video', to: 'room#change_http'
  patch '/room/:id/seekvideo', to: 'room#seek_http'
  post '/room/:id/stop', to: 'room#stop_http'
  post '/room/:id/play', to: 'room#play_http'
  post '/room/:id/pause', to: 'room#pause_http'

  mount ActionCable.server => '/cable'
  # resources :home, only: :index
end
