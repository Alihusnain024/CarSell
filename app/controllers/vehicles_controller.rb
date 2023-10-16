class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  


  def index
    @vehicles = current_user.vehicles.where.not(primaryContact: nil)
  end

  def show
  end

  def new
    @vehicle = current_user.vehicles.new
  end

  def create
    @vehicle = current_user.vehicles.new
    @vehicle.save(validate: false)
    redirect_to vehicle_step_path(@vehicle, :step1)
  end

  def edit
  end

  def update
    if @vehicle.update(vehicle_params)
      redirect_to @vehicle, notice: 'Vehicle was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @vehicle.destroy
    redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.'
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(:city, :mileage, :carModel, :price, :engineType, :transmissonType, :engineCapicity, :color, :assemblyType, :description, :primaryContact, :secondaryContact)
  end
end
