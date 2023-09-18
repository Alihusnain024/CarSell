class FavouritesController < ApplicationController
  def index
  end

  def add_to_favorites
    @vehicle = Vehicle.find(params[:vehicle_id])
    current_user.favorites.create(vehicle: @vehicle)
    redirect_to :back, notice: 'Added to favorites'
  end
  

  def remove_from_favorites
    @vehicle = Vehicle.find(params[:vehicle_id])
    current_user.favorites.find_by(vehicle: @vehicle).destroy
    redirect_to :back, notice: 'Removed from favorites'
  end
end
end
