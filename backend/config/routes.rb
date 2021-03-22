# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{Rails.application.config.available_locales.join('|')}/ do
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

    get '/me', controller: :users, action: :me

    resources :changes
    resources :system_settings
    resources :codelist_items

    namespace :admin do
      resources :users, only: %i[index show update] do
        resources :changes, only: [:index], controller: 'users/changes'
      end
    end
  end
end
