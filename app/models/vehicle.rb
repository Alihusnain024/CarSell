class Vehicle < ApplicationRecord
  include PgSearch::Model

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
  enum status: {
    open: 0,
    close: 1
  }

  belongs_to :user
  has_many_attached :vehicle_image

  multisearchable against: [:carModel, :city, :price, :engineType, :transmissonType, :color, :mileage, :engineCapicity, :assemblyType]


  attr_accessor :form_step

  cattr_accessor :form_steps do
  	%w(step1 step2 step3) 
  end
  def required_for_step?(step)
    return true if form_step.nil?
  
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
  validates :city, :carModel, :engineType, :color, :assemblyType, :mileage, :price, :description, :transmissonType, :engineCapicity, presence: true,
  if: -> { required_for_step?(:step1) }

  validates :primaryContact, :secondaryContact, presence: true,
  if: -> { required_for_step?(:step2) }

  validates :vehicle_image, presence: true,
  if: -> { required_for_step?(:step3) }

  def self.search_results(query_params)
    if query_params.present?
      searchable_ids = PgSearch.multisearch(query_params.values.reject(&:blank?)).pluck(:searchable_id)
      where(id: searchable_ids, status: 'open')
    else
      open.where.not(primaryContact: nil)
    end
  end

  def self.user_ads(user)
    where(user: user).where.not(primaryContact: nil)
  end

  
end
