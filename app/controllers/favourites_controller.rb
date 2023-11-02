class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [:add_to_favorites, :remove_from_favorites] 

  def index
    @pagy, @favorite_vehicles = pagy(Favorite.favorite_vehicles_for_user(current_user), items: 4)
  end
  

  def add_to_favorites
     current_user.favorites.create(vehicle: @vehicle)
     redirect_back(fallback_location: root_path, notice: 'Added to favorites')
   
  end
  
  def remove_from_favorites  
    current_user.favorites.find_by(vehicle: @vehicle).destroy
    redirect_back(fallback_location: root_path, notice: 'Removed from favorites')
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  
  
end

