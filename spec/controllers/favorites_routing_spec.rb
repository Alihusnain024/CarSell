require 'rails_helper'

RSpec.describe FavouritesController, type: :routing do
  describe 'routing' do
    it 'routes to #add_to_favorites' do
      expect(post: '/favourites/1/add_to_favorites').to route_to('favourites#add_to_favorites', id: '1')
    end  
    it 'routes to #remove_from_favorites' do
      expect(delete: '/favourites/1/remove_from_favorites').to route_to('favourites#remove_from_favorites', id: '1')
    end
  end
end
