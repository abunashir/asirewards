Rails.application.routes.draw do
  root to: "home#index"
  resource :account
  resources :certificates
end
