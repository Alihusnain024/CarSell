require 'rails_helper'
RSpec.describe VehiclesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:vehicle) { FactoryBot.create(:vehicle) }

  before do
    sign_in user 
  end

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

  describe 'GET #show' do
    it 'returns a success response' do
      vehicle = create(:vehicle, user: user)
      get :show, params: { id: vehicle.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #close' do
    it 'updates the vehicle status to "close"' do
      put :close, params: { id: vehicle.id }
      vehicle.reload
      expect(vehicle.status).to eq('close')
      expect(response).to redirect_to(vehicles_path)
      expect(flash[:notice]).to eq('Vehicle status has been set to close.')
    end
  end

  describe 'PATCH #update' do
    let(:vehicle) { create(:vehicle) }
  
    context 'with valid parameters' do
      it 'updates the vehicle and redirects to the vehicle' do
        valid_params = vehicle.attributes.merge(city: 'Valid City')
        patch :update, params: { id: vehicle.id, vehicle: valid_params }
        expect(response).to redirect_to(vehicle)
      end
    end    
  end
  

  describe 'POST #create' do
    it 'saves the vehicle with validation disabled and redirects to vehicle step 1' do
      vehicle_params = attributes_for(:vehicle) 

      expect {
        post :create, params: { vehicle: vehicle_params }
      }.to change(Vehicle, :count).by(1)

      expect(response).to redirect_to(vehicle_step_path(Vehicle.last, :step1))
    end
  end

  describe 'GET #edit' do
    let(:vehicle) { create(:vehicle) }

    it 'redirects to vehicle step 1' do
      get :edit, params: { id: vehicle.id }

      expect(response).to redirect_to(vehicle_step_path(vehicle, :step1))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the vehicle and redirects to vehicles_url' do
      create(:favorite, user: user, vehicle: vehicle) 

      expect {
        delete :destroy, params: { id: vehicle.id }
      }.to change(Vehicle, :count).by(-1)

      expect(response).to redirect_to(vehicles_url)
      expect(flash[:notice]).to eq('Vehicle was successfully destroyed.')
    end
  end

  describe 'GET #search' do
    it 'returns a successful response' do
      get :search, params: { query_params: { param1: 'value1', param2: 'value2' } }
      expect(response).to have_http_status(:success)
    end

    it 'renders the search template' do
      get :search, params: { query_params: { param1: 'value1', param2: 'value2' } }
      expect(response).to render_template('search')
    end
  end

  


end