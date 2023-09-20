class VehiclesController < ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy]
  
  def index
   @pagy, @vehicles = pagy(current_user.vehicles.where.not(primaryContact: nil), items:3)
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
    @vehicle = Vehicle.find(params[:id])
    Favorite.where(vehicle_id: @vehicle.id).destroy_all
    @vehicle.destroy
    redirect_to vehicles_url, notice: 'Vehicle was successfully destroyed.'
  end
  
  

  def search
    begin
      if params[:query_params].present?
        @pagy, @results = pagy(Vehicle.where(id: PgSearch.multisearch(params[:query_params].values.reject(&:blank?)).pluck(:searchable_id)), items: 3)
      else
        @pagy, @results = pagy(Vehicle.all.where.not(primaryContact: nil).where(status: "open"), items: 3)
      end
    rescue StandardError => e
      flash[:alert] = "An error occurred while processing your request."
      Rails.logger.error("Error in VehiclesController#search: #{e.message}")
      @pagy = nil
      @results = []
    end
  
    render :search
  end

  def close
    @vehicle = Vehicle.find(params[:id]) 
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
