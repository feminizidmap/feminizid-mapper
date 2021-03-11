# frozen_string_literal: true

Rails.application.routes.draw do
  post '/signup', controller: :signup, action: :create
  post '/refresh', controller: :refresh, action: :create
  post '/signin', controller: :signin, action: :create
  delete '/signin', controller: :signin, action: :destroy

  resources :changes

  get '/me', controller: :users, action: :me

  namespace :admin do
    resources :users, only: [:index]
  end
end
