Rails.application.routes.draw do
  root "bubbles#index"

  resource :session

  resources :bubbles do
    resources :boosts
    resources :categories, shallow: true
    resources :comments
  end

  resources :categories, only: :index

  get "up", to: "rails/health#show", as: :rails_health_check
end
