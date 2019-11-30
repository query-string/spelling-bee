Rails.application.routes.draw do
  resources :lists, only: :index do
    resources :attempts, only: %i[new create show]
  end
  namespace :my do
    resources :words, only: %i[index show update]
  end
  root "application#index"
end
