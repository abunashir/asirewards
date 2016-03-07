Rails.application.routes.draw do
  root to: "activations#index"
  resource :account

  resources :certificates do
    resource :preview, only: :show
    resources :kits
  end

  resources :orders
  resources :activations
  resource :marketer
end
