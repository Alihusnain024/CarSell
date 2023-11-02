require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'Associations' do
    it { should belong_to(:vehicle) }
    it { should belong_to(:user)}
  end

  describe '.favorite_vehicles_for_user' do
    let(:user) { create(:user) }
    let(:open_vehicle) { create(:vehicle, status: 'open') }
    let(:closed_vehicle) { create(:vehicle, status: 'close') }

    it 'returns favorite vehicles with "open" status for the user' do
      favorite1 = create(:favorite, user: user, vehicle: open_vehicle)
      favorite2 = create(:favorite, user: user, vehicle: closed_vehicle)
      favorite3 = create(:favorite, user: user, vehicle: open_vehicle)

      favorites = Favorite.favorite_vehicles_for_user(user)

      expect(favorites).to include(favorite1, favorite3)
      expect(favorites).not_to include(favorite2)
    end
  end
end
