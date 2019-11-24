Rails.application.routes.draw do
  resources :lists, only: %i[index show update] do
    resources :attempts
  end
  namespace :my do
    resources :words, only: %i[index show]
  end
  root "lists#index"
end
