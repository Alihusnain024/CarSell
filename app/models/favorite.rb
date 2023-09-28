class Favorite < ApplicationRecord
  belongs_to :vehicle
  belongs_to :user

  def self.favorite_vehicles_for_user(user)
    includes(:vehicle).where(vehicles: { status: 'open' })
                     .where(user: user)
                     .order(created_at: :desc)
  end
end
