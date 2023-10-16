class Api::VehiclesController < Api::ApplicationController
  before_action :set_vehicle, only: [:show, :edit, :update, :destroy, :close]
  before_action :authenticate_user!, except: [:search]
  before_action :set_current_user, only: [:new, :create]
  before_action :new_vehicle, only: [:new, :create]


  def index
     @vehicles = Vehicle.user_ads(current_user)
    render json: @vehicles
  end

  def show
    render json: @vehicle
  end

  def new
    render json: @vehicle
  end

  def create
    @vehicle = @user.vehicles.new(vehicle_params)
  
    if @vehicle.save
      render json: { message: 'Vehicle created successfully', vehicle: @vehicle }, status: :created
    else
      render json: { error: 'Failed to create vehicle', errors: @vehicle.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  def edit
    render json: @vehicle
  end

  def update
    if @vehicle.update(vehicle_params)
      render json: { message: 'Vehicle updated successfully', vehicle: @vehicle }
    else
      render json: { error: 'Failed to update vehicle', errors: @vehicle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return unless Favorite.where(vehicle_id: @vehicle.id).destroy_all && @vehicle.destroy

    render json: { message: 'Vehicle destroyed successfully' }
  end

  def search
    @results = Vehicle.search_results(params[:query_params])
    render json: @results
  end

  def close
    debugger
    @vehicle.update(status: 'close')
    render json: { message: 'Vehicle status has been set to close', vehicle: @vehicle }
  end

  private

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end

  def set_current_user 
    @user = current_user
  end 

  def new_vehicle 
    @vehicle = @user.vehicles.new
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
