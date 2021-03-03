require 'rails_helper'

RSpec.describe ChangesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  let(:valid_attributes) {
    { status: :created }
  }

  let(:invalid_attributes) {
    { status: "foo" }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:change) { FactoryBot.create(:change, user: user) }

    pending 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq change.id
    end

    # usually there's no need to test this kind of stuff
    # within the resources endpoints
    # the quick spec is here only for the presentation purposes
    it 'unauth without cookie' do
      get :index
      expect(response).to have_http_status(401)
    end
  end

  describe 'GET #show' do
    let!(:change) { FactoryBot.create(:change, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: change.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new Change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { change: valid_attributes }
        }.to change(Change, :count).by(1)
      end

      it 'renders a JSON response with the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { change: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response.location).to eq(change_url(Change.last))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { change: valid_attributes }
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the new change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { change: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT #update' do
    let!(:change) { FactoryBot.create(:change, user: user) }

    context 'with valid params' do
      let(:new_attributes) {
        { status: :reviewed }
      }

      it 'updates the requested change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.id, change: new_attributes }
        change.reload
        expect(change.status).to eq new_attributes[:status].to_s
      end

      it 'renders a JSON response with the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.to_param, change: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      pending 'renders a JSON response with errors for the change' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: change.to_param, change: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:change) { FactoryBot.create(:change, user: user) }

    pending 'destroys the requested change' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect {
        delete :destroy, params: { id: change.id }
      }.to change(Change, :count).by(-1)
    end
  end
end
