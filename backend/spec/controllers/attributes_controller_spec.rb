# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttributesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:entity) { FactoryBot.create(:entity) }
  let(:category) { FactoryBot.create(:category) }
  let(:category_item) { FactoryBot.create(:category_item) }

  let(:valid_attributes) do
    { entity_id: entity.id,
      category_id: category.id,
      category_item_id: category_item.id }
  end

  let(:invalid_attributes) do
    { category_item_id: 'foo' }
  end

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:attribute) { FactoryBot.create(:attribute) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index, params: { entity_id: attribute.entity.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq attribute.id
    end

    it 'unauth without cookie' do
      get :index, params: { entity_id: attribute.entity.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
    let!(:attribute) { FactoryBot.create(:attribute) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: attribute.id, entity_id: attribute.entity.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new attribute' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect do
          post :create, params: { attribute: valid_attributes, entity_id: entity.id }
        end.to change(Attribute, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { attribute: valid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(entity_attributes_url(Attribute.last.id, Attribute.last.entity.id))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { attribute: valid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { attribute: invalid_attributes, entity_id: entity.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:attribute) { FactoryBot.create(:attribute) }

    context 'with valid params' do
      let(:new_cat_item) { FactoryBot.create(:category_item) }
      let(:new_attributes) do
        { category_item_id: new_cat_item.id }
      end

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: attribute.id, attribute: new_attributes, entity_id: attribute.entity.id }
        attribute.reload
        expect(attribute.category_item_id).to eq new_attributes[:category_item_id].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: attribute.to_param, attribute: valid_attributes, entity_id: attribute.entity.id }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: attribute.to_param, attribute: invalid_attributes, entity_id: attribute.entity.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:attribute) { FactoryBot.create(:attribute) }

    it 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect(Attribute.count).to be(1)
      delete :destroy, params: { id: attribute.id, entity_id: attribute.entity.id }
      expect(Attribute.count).to be(0)
    end
  end
end
