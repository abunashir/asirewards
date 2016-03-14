Rails.application.routes.draw do
  root to: "activations#index"
  resource :account

  resources :certificates do
    resource :content
    resources :kits
  end

  resources :orders
  resources :activations
  resource :marketer
  resources :staffs
end
