require 'rails_helper'
RSpec.describe VehiclesController, type: :controller do
  let(:user) { create(:user) } 
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:vehicle) { create(:vehicle) } 

    it 'returns a success response' do
      get :show, params: { id: vehicle.id }
      expect(response).to have_http_status(:success)
    end
  end


end