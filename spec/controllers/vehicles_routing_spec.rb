require 'rails_helper'

RSpec.describe VehiclesController, type: :routing do
  describe 'routing' do
    it 'routes to vehicles#index' do
      expect(get: '/vehicles').to route_to('vehicles#index')
    end
  
    it 'routes to vehicles#show' do
      expect(get: '/vehicles/1').to route_to('vehicles#show', id: '1')
    end
  
    it 'routes to vehicles#update' do
      expect(put: '/vehicles/1').to route_to('vehicles#update', id: '1')
    end
  
    it 'routes to vehicles#search' do
      expect(get: '/vehicles/search').to route_to('vehicles#search')
    end
  
    it 'routes to vehicles#close' do
      expect(put: '/vehicles/1/close').to route_to('vehicles#close', id: '1')
    end
  
    it 'routes to steps#show' do
      expect(get: '/vehicles/1/steps/2').to route_to('vehicle/steps#show', vehicle_id: '1', id: '2')
    end
  
    it 'routes to steps#update' do
      expect(put: '/vehicles/1/steps/2').to route_to('vehicle/steps#update', vehicle_id: '1', id: '2')
    end
  end
end
