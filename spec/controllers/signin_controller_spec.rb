# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SigninController, type: :controller do
  describe 'POST #create' do
    let(:password) { 'querty' }
    let(:user) { FactoryBot.create(:user, { password: 'querty' }) }
    let(:user_params) { { email: user.email, password: password } }

    it 'returns http success' do
      post :create, params: user_params
      expect(response).to be_successful
      expect(response_json.keys).to eq ['csrf']
      expect(response.cookies[JWTSessions.access_cookie]).to be_present
    end

    it 'returns unauthorized for invalid params' do
      post :create, params: { email: user.email, password: 'incorrect' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
