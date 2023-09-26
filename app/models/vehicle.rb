class Vehicle < ApplicationRecord
  enum status: {
    open: 0,
    close: 1
  }
  belongs_to :user
  attr_accessor :form_step
  has_many_attached :vehicle_image
  
  include PgSearch::Model

  multisearchable against: [:carModel, :city, :price, :engineType, :transmissonType, :color, :mileage, :engineCapicity, :assemblyType]

  def self.search_all(query_params)
    debugger
    vehicles = Vehicle.all
    if query_params && query_params[:query].present?
      vehicles = vehicles.search(query_params[:query])
    end
    vehicles
  end
  

  enum city: {
    rawalpindi: 'rawalpindi',
    lahore: 'lahore',
    quetta: 'quetta',
    karachi: 'karachi',
    peshawar: 'peshawar',
    islamabad: 'islamabad'
  }
  enum carModel: {
    suzuki: 'suzuki',
    toyota: 'toyota',
    honda: 'honda',
    bmw: 'bmv'
  }
 
  enum engineType: {
    petrol: 'petrol',
    diesel: 'diesel',
    hybrid: 'hybrid'
  }
  enum color: {
    black: 'black',
    white: 'white',
    gray: 'gray',
    silver: 'silver',
    red: 'red'
  }
  enum assemblyType: {
    local: 'local',
    imported: 'imported'
  }

  cattr_accessor :form_steps do
  	%w(step1 step2 step3) 
  end
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
  
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
  validates :city, :carModel, :engineType, :color, :assemblyType, :mileage, :price, :description, :transmissonType, :engineCapicity, presence: true,
  if: -> { required_for_step?(:step1) }

    validates :primaryContact, :secondaryContact, presence: true,
  if: -> { required_for_step?(:step2) }

    validates :vehicle_image, presence: true,
    if: -> { required_for_step?(:step3) }


 
end
