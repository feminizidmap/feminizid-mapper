# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefreshController, type: :controller do
  let(:access_cookie) { @tokens[:access] }
  let(:csrf_token) { @tokens[:csrf] }

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    context 'when successful' do
      before do
        # set expiration time to 0 to create an already expired access token
        JWTSessions.access_exp_time = 0
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload,
                                           refresh_by_access_allowed: true,
                                           namespace: "user_#{user.id}")
        @tokens = session.login
        JWTSessions.access_exp_time = 3600
      end

      it do
        request.cookies[JWTSessions.access_cookie] = access_cookie
        request.headers[JWTSessions.csrf_header] = csrf_token
        post :create
        expect(response).to be_successful
        expect(response_json.keys.sort).to eq ['csrf']
        expect(response.cookies[JWTSessions.access_cookie]).to be_present
      end
    end

    context 'when failure' do
      before do
        payload = { user_id: user.id }
        session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
        @tokens = session.login
      end

      it do
        request.cookies[JWTSessions.access_cookie] = access_cookie
        request.headers[JWTSessions.csrf_header] = csrf_token
        post :create
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
