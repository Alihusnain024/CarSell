class FavouritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: [:add_to_favorites, :remove_from_favorites] 

  def index
    @pagy, @favorite_vehicles = pagy(Favorite.favorite_vehicles_for_user(current_user), items: 4)
  end
  

  def add_to_favorites
    if current_user.favorites.create(vehicle: @vehicle)
      redirect_back(fallback_location: root_path, notice: 'Added to favorites')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to add to favorites')
    end
  end
  
  def remove_from_favorites  
    if current_user.favorites.find_by(vehicle: @vehicle).destroy
      redirect_back(fallback_location: root_path, notice: 'Removed from favorites')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to remove from favorites')
    end
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  
  
end

