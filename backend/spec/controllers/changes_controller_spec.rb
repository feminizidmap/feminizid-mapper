# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChangesController, type: :controller do
  let(:user) { create(:user) }
  let(:record) { create(:record) }

  let(:valid_attributes) do
    { status: :created,
      record_id: record.id }
  end

  let(:invalid_attributes) do
    { status: 'foo',
      record_id: record.id }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:change) { create(:change, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index, params: { record_id: change.record.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq change.id
    end

    # usually there's no need to test this kind of stuff
    # within the resources endpoints
    # the quick spec is here only for the presentation purposes
    it 'unauth without cookie' do
      get :index, params: { record_id: change.record.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let!(:change) { create(:change, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: change.id, record_id: change.record.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { change: valid_attributes, record_id: record.id }
        end.to change(Change, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { change: valid_attributes, record_id: record.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(record_changes_url(Change.last, Change.last.record_id))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { change: valid_attributes, record_id: record.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { change: invalid_attributes, record_id: record.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:change) { create(:change, user: user) }

    context 'with valid params' do
      let(:new_attributes) do
        { status: :reviewed }
      end

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.id, change: new_attributes, record_id: record.id }
        change.reload
        expect(change.status).to eq new_attributes[:status].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.to_param, change: valid_attributes, record_id: record.id }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.to_param, change: invalid_attributes, record_id: record.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:change) { create(:change, user: user) }

    it 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect(Change.count).to be(1)
      delete :destroy, params: { id: change.id, record_id: record.id }
      expect(Change.count).to be(0)
    end
  end
end
