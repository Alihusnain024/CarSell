class FavouritesController < ApplicationController
  def index
    @favorite_vehicles = current_user.favorites.includes(:vehicle).where(vehicles: { status: 'open' })
  end

  def add_to_favorites
    @vehicle = Vehicle.find(params[:id])
    if current_user.favorites.create(vehicle: @vehicle)
      redirect_back(fallback_location: root_path, notice: 'Added to favorites')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to add to favorites')
    end
  end
  
  def remove_from_favorites
    @vehicle = Vehicle.find(params[:id])
  
    if current_user.favorites.find_by(vehicle: @vehicle).destroy
      redirect_back(fallback_location: root_path, notice: 'Removed from favorites')
    else
      redirect_back(fallback_location: root_path, alert: 'Failed to remove from favorites')
    end
  end
  
end

