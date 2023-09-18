class Vehicle::StepsController < ApplicationController
  include Wicked::Wizard
  steps *Vehicle.form_steps

  def show
    @vehicle = Vehicle.find(params[:vehicle_id])
    render_wizard
  end

  def update
    @vehicle = Vehicle.find(params[:vehicle_id])
    @vehicle.update(vehicle_params(step))
    render_wizard @vehicle
  end

  private

  def vehicle_params(step)
  	permitted_attributes = case step
  	  when "step1"
  	    [:city, :mileage, :carModel, :price,:engineType, :transmissonType, :engineCapicity, :color, :assemblyType, :description]
  	  when "step2"
  	    [:primaryContact, :secondaryContact]
      when "step3"
        [:vehicle_image]
  
  	  end

  	params.require(:vehicle).permit(permitted_attributes).merge(form_step: step)
  end
end
