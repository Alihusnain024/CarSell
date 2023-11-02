require 'rails_helper'

RSpec.describe Vehicle, type: :model do
    describe 'Associations' do
      it { should belong_to(:user) }
    end 

    describe 'Validations' do
      it { is_expected.to validate_presence_of :engineCapicity }
      it { is_expected.to validate_presence_of :mileage}
      it { is_expected.to validate_presence_of :price }
      it { is_expected.to validate_presence_of :primaryContact }
      it { is_expected.to validate_presence_of :city }
      it { is_expected.to validate_presence_of :color }
      it { is_expected.to validate_presence_of :engineType }
      it { is_expected.to validate_presence_of :assemblyType }
      it { is_expected.to validate_presence_of :transmissonType }
      it { is_expected.to validate_presence_of :carModel }

      it 'should be valid with factory defaults' do
        vehicle = FactoryBot.build(:vehicle)
        expect(vehicle).to be_valid
      end

      it 'should be invalid without a city' do
        vehicle = FactoryBot.build(:vehicle, city: nil)
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1) 
      end
      it 'should be invalid without blank city' do
        vehicle= FactoryBot.build(:vehicle, city: '')
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)
      end

      it 'should be invalid without a carModal' do
        vehicle=FactoryBot.build(:vehicle, carModel: nil)
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)  
      end

      it 'should be invalid with blank carModel' do
        vehicle=FactoryBot.build(:vehicle, carModel: '')
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)
      end

      it 'should be invalid with blank price' do
        vehicle=FactoryBot.build(:vehicle, price: '')
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)
      end
      it 'should be invalid without a price' do
        vehicle=FactoryBot.build(:vehicle, price: nil)
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)  
      end
      it 'should be invalid with blank mileage' do
        vehicle=FactoryBot.build(:vehicle, mileage:'')
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)
      end
      it 'should be invalid without mileage' do
        vehicle=FactoryBot.build(:vehicle, mileage:nil)
        expect(vehicle).to_not be_valid
        expect(vehicle.errors.full_messages.size).to eq(1)
      end

    end

    describe 'user_ads' do
      let(:user) { create(:user) }
      it 'returns vehicles associated with the given user and with a non-nil primaryContact' do
        user_vehicle = create(:vehicle, user: user, primaryContact: '03445381776')
        results = Vehicle.user_ads(user)
        expect(results).to include(user_vehicle)
      end
    end

    describe '.search_results' do
      let!(:vehicle1) { create(:vehicle, status: 'open', city: 'lahore') }
      let!(:vehicle2) { create(:vehicle, status: 'open', city: 'karachi') }
      let!(:vehicle3) { create(:vehicle, status: 'open', city: 'lahore') }
      let!(:vehicle4) { create(:vehicle, status: 'close') }
  
      context 'when query_params are present' do
        it 'returns vehicles that match the search' do
          query_params = { param1: 'lahore'}
  
          results = Vehicle.search_results(query_params)
  
          expect(results).to include(vehicle1)
          expect(results).to include(vehicle3)
          expect(results).not_to include(vehicle2)
          expect(results).not_to include(vehicle4)
        end
  
        it 'returns an empty result if no vehicles match the search' do
          query_params = { param1: 'Invalid', param2: 'Search' }
  
          results = Vehicle.search_results(query_params)
  
          expect(results).to be_empty
        end
      end
  
      context 'when query_params are not present' do
        it 'returns open vehicles with non-nil primaryContact' do
          results = Vehicle.search_results({})
  
          expect(results).to include(vehicle1)
          expect(results).to include(vehicle2)
          expect(results).to include(vehicle3)
          expect(results).not_to include(vehicle4)
        end
      end
    end 
end