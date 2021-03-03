Rails.application.routes.draw do
  post '/signup', controller: :signup, action: :create
  post '/refresh', controller: :refresh, action: :create
  post '/signin', controller: :signin, action: :create
  delete '/signin', controller: :signin, action: :destroy

  resources :changes

  # namespace :api do
  #   namespace :v1 do
  #   end
  # end
end
