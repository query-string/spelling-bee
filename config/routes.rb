Rails.application.routes.draw do
  resources :lists, only: %i[index show]
  root "lists#index"
end
