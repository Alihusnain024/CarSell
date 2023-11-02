Rails.application.routes.draw do
  devise_for :users
  root to: "vehicles#search"
  
  resources :lists, only: [:index, :create]
  resources :payments, only: [:new, :create]
  get 'payment_success', to: 'payments#create', as: 'payment_success'
  get 'payment_cancel', to: 'payments#new', as: 'payment_cancel'

  
  resources :vehicles do 
    resources :steps, only: [:show, :update], controller: 'vehicle/steps'
    collection do
      get 'search'
    end
    member do
      put 'close'
      get 'payment'
      post 'process_payment'
      
    end
  end

  resources :favourites, only: [:index, :create, :destroy] do
    member do
      post 'add_to_favorites'
      delete 'remove_from_favorites'
    end
  end

  namespace :api do
    post :auth, to: "authentication#create"
    delete :auth, to: "authentication#destroy"
    resources :vehicles do 
      resources :steps, only: [:show, :update], controller: 'vehicle/steps'
      collection do
        get 'search'
      end                                                                 
      member do
        put 'close'
      end
    end
  
    resources :favourites, only: [:index, :create, :destroy] do
      member do
        post 'add_to_favorites'
        delete 'remove_from_favorites'
      end
    end
    
  end

end
