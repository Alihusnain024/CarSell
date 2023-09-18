Rails.application.routes.draw do
  get 'favourites/index'
  devise_for :users
  root to: "vehicles#search"
  resources :vehicles do 
    resources :steps, only: [:show, :update], controller: 'vehicle/steps'
    collection do
      get 'search'
    end
  end

  resources :favorites, only: [:index, :create, :destroy] do
    member do
      post 'add_to_favorites'
      delete 'remove_from_favorites'
    end
  end
  
  
  

end
