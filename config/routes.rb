Rails.application.routes.draw do
  root to: "home#index"
  resource :account

  resources :certificates do
    resource :preview, only: :show
  end

  resources :orders
  resources :distributions
end
