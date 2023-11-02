require 'rails_helper'

RSpec.describe FavouritesController, type: :controller do

 let(:user) { FactoryBot.create(:user) }
 let(:vehicle) { FactoryBot.create(:vehicle) }
 let(:vehicle1) { create(:vehicle) }
 let(:vehicle2) { create(:vehicle) }
 let(:vehicle3) { create(:vehicle) }
 let(:favorite1) { create(:favorite, user: user, vehicle: vehicle1) }
 let(:favorite2) { create(:favorite, user: user, vehicle: vehicle2) }
 let(:favorite3) { create(:favorite, user: user, vehicle: vehicle3) }

  before do
    sign_in user 
  end

  describe 'GET #index' do
    it 'assigns @favorite_vehicles' do
      get :index
      expect(assigns(:favorite_vehicles)).to include(favorite1, favorite2, favorite3)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #add_to_favorites' do
    it 'creates a favorite for the vehicle and redirects with notice' do
      expect {
        post :add_to_favorites, params: { id: vehicle.id }
      }.to change(Favorite, :count).by(1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Added to favorites')
    end
  end

  describe 'Delete #remove_from_favorites' do
    it 'removes a favorite for the vehicle and redirects with notice' do
      user.favorites.create(vehicle: vehicle)

      expect {
        delete :remove_from_favorites, params: { id: vehicle.id }
      }.to change(Favorite, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Removed from favorites')
    end
  end
  


end