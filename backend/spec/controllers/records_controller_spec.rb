# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    { identifier: '2021-02-18-xx' }
  end

  let(:invalid_attributes) do
    { blob: 'foo' }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:record) { create(:record) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq record.id
    end

    it 'unauth without cookie' do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let!(:record) { create(:record) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: record.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new record' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { record: valid_attributes }
        end.to change(Record, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { record: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(records_url(Record.last))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { record: valid_attributes }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { record: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:record) { create(:record) }

    context 'with valid params' do
      let(:new_attributes) do
        { identifier: '2021-11-11-München' }
      end

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: record.id, record: new_attributes }
        record.reload
        expect(record.identifier).to eq new_attributes[:identifier].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: record.to_param, record: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: record.to_param, record: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:record) { create(:record) }

    it 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect(Record.count).to be(1)
      delete :destroy, params: { id: record.id }
      expect(Record.count).to be(0)
    end
  end
end
