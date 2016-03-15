Rails.application.routes.draw do
  root to: "activations#index"
  resource :account

  resources :certificates do
    resource :content
    resources :kits do
      resource :download
    end
  end

  resources :orders
  resources :activations
  resource :marketer
  resources :staffs
  resources :destinations
end
