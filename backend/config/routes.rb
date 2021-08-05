# frozen_string_literal: true

Rails.application.routes.draw do
  post '/signup', controller: :signup, action: :create
  post '/refresh', controller: :refresh, action: :create
  post '/signin', controller: :signin, action: :create
  delete '/signin', controller: :signin, action: :destroy

  resources :password_resets, only: [:create] do
    collection do
      get ':token', action: :edit, as: :edit
      patch ':token', action: :update
    end
  end

  resources :users, controller: :users, only: %i[update destroy]
  get '/me', controller: :users, action: :me

  resources :system_settings
  resources :records do
    resources :sources
    resources :changes
  end

  resources :entities do
    resources :attributes
    resources :fields
  end

  resources :categories
  resources :category_items

  namespace :admin do
    resources :users do
      resources :changes, only: [:index], controller: 'users/changes'
    end
  end
end
