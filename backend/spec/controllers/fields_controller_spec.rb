# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldsController, type: :controller do
  let(:user) { create(:user) }
  let(:entity) { create(:entity) }

  let(:valid_attributes) do
    { entity_id: entity.id,
      name: 'Test',
      key: 'test',
      value: 'bla' }
  end

  let(:invalid_attributes) do
    { entity_id: 'foo' }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:field) { create(:field) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index, params: { entity_id: field.entity.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq field.id
    end

    it 'unauth without cookie' do
      get :index, params: { entity_id: field.entity.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let!(:field) { create(:field) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: field.id, entity_id: field.entity.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new field' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { field: valid_attributes, entity_id: entity.id }
        end.to change(Field, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { field: valid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(entity_fields_url(Field.last.id, Field.last.entity.id))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { field: valid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { field: invalid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:field) { create(:field) }

    context 'with valid params' do
      let(:new_attributes) do
        { name: 'postit' }
      end

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: field.id, field: new_attributes, entity_id: field.entity.id }
        field.reload
        expect(field.name).to eq new_attributes[:name].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: field.to_param, field: valid_attributes, entity_id: field.entity.id }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: field.to_param, field: invalid_attributes, entity_id: field.entity.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:field) { create(:field) }

    it 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect(Field.count).to be(1)
      delete :destroy, params: { id: field.id, entity_id: field.entity.id }
      expect(Field.count).to be(0)
    end
  end
end
