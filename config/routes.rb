Rails.application.routes.draw do
  root to: "activations#index"
  resource :account

  resources :certificates do
    resources :destinations, controller: "certificate_destinations"
    resource :content
    resources :kits do
      resource :download
    end
  end

  resources :orders
  resources :activations
  resource :marketer
  resources :staffs
  resources :destinations do
    resources :bookings
  end

  resources :purchases do
    resource :complete
  end

  namespace :admin do
    resources :certificates
    resources :users
    resources :destinations
    resources :orders
  end

  resource :contact
end
