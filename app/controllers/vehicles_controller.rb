class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy, :close]
  before_action :authenticate_user!, except: [:search]  
  
  def index
   @pagy, @vehicles = pagy(Vehicle.user_ads(current_user), items:3)
  end

  def show; end

  def new
    @vehicle = current_user.vehicles.new
  end

  def create
    @vehicle = current_user.vehicles.new
    @vehicle.save(validate: false)
    redirect_to vehicle_step_path(@vehicle, :step1)
  end

  def edit
    redirect_to vehicle_step_path(@vehicle, :step1)
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Vehicle was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    return unless Favorite.where(vehicle_id: @vehicle.id).destroy_all && @vehicle.destroy
    redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.'
  end
  
  def search
    @pagy, @results = pagy(Vehicle.search_results(params[:query_params]), items: 3)
    respond_to do |format|
      format.html 
      format.js   
    end
  end
  
  def close
    @vehicle.update(status: 'close') 
    redirect_to vehicles_path, notice: 'Vehicle status has been set to close.'
  end
  
  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(
      :city,
      :mileage,
      :carModel,
      :price,
      :engineType,
      :transmissonType, 
      :engineCapicity, 
      :color, 
      :assemblyType, 
      :description, 
      :primaryContact, 
      :secondaryContact,
      :status,
      vehicle_image: []
    )
  end

end
