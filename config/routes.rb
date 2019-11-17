Rails.application.routes.draw do
  resources :lists, only: %i[index show update]
  namespace :my do
    resources :profile, only: :index
  end
  root "lists#index"
end
