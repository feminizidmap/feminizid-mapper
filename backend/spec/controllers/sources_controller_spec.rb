# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SourcesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:record) { FactoryBot.create(:record) }

  let(:valid_attributes) do
    { url: 'http://foo.bar' }
  end

  let(:invalid_attributes) do
    { url: 'foo' }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:source) { FactoryBot.create(:source) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index, params: { record_id: source.record.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq source.id
    end

    it 'unauth without cookie' do
      get :index, params: { record_id: source.record.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let!(:source) { FactoryBot.create(:source) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: source.id, record_id: source.record.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new source' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { source: valid_attributes, record_id: record.id }
        end.to change(Source, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { source: valid_attributes, record_id: record.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(record_source_url(Source.last.id, Source.last.record.id))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { source: valid_attributes, record_id: record.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { source: invalid_attributes, record_id: record.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:source) { FactoryBot.create(:source) }

    context 'with valid params' do
      let(:new_attributes) do
        { url: 'https://bar.baz' }
      end

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: source.id, source: new_attributes, record_id: source.record.id }
        source.reload
        expect(source.url).to eq new_attributes[:url].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: source.to_param, source: valid_attributes, record_id: source.record.id }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: source.to_param, source: invalid_attributes, record_id: source.record.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:source) { FactoryBot.create(:source) }

    it 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect(Source.count).to be(1)
      delete :destroy, params: { id: source.id, record_id: source.record.id }
      expect(Source.count).to be(0)
    end
  end
end
