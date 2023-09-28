class VehiclePolicy < ApplicationPolicy
  alias vehicle record

  def edit?
    creator?
  end

  def destroy?
    creator?
  end

  def update?
    creator?
  end
  private

  def creator?
    user.id == vehicle.user_id
  end


end
