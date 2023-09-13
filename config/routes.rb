Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :vehicles do 
    resources :steps, only: [:show, :update], controller: 'vehicle/steps'
  end
end
