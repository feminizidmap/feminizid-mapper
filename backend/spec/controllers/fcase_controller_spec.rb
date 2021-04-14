# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FcaseController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let!(:fcase) { FactoryBot.create(:fcase) }

  let(:valid_attributes) do
    { ident: '2021-11-20-lalalala' }
  end

  let(:invalid_attributes) do
    { ident: '' }
  end

  describe 'GET #index' do
    it 'allows users to receive fcases' do
      sign_in_as(user)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json['data'].first['id']).to eq fcase.id
    end
  end

  describe 'GET #show' do
    it 'allows user to receive a single fcase' do
      sign_in_as(user)
      get :show, params: { id: fcase.id }
      expect(response).to be_successful
      expect(response_json['data']['id']).to eq fcase.id
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Fcase' do
        sign_in_as(user)
        expect do
          post :create, params: { fcase: valid_attributes }
        end.to change(Fcase, :count).by(1)
      end

      it 'renders a JSON response with the new fcase' do
        sign_in_as(user)
        post :create, params: { fcase: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response_json['ident']).to eq valid_attributes[:ident]
        expect(response.location).to eq case_url(Fcase.last)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new fcase' do
        sign_in_as(user)
        post :create, params: { fcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    let!(:fcase) { FactoryBot.create(:fcase) }

    context 'with valid params' do
      let(:new_attributes) do
        { ident: '2021-04-30-foo' }
      end

      it 'updates the requested fcase' do
        sign_in_as(user)
        put :update, params: { id: fcase.id, fcase: new_attributes }
        fcase.reload
        expect(fcase.ident).to eq new_attributes[:ident].to_s
      end

      it 'renders a JSON response with the fcase' do
        sign_in_as(user)
        put :update, params: { id: fcase.id, fcase: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the change' do
        sign_in_as(user)
        put :update, params: { id: fcase.id, fcase: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:fcase) { FactoryBot.create(:fcase) }

    it 'destroys the requested fcase' do
      sign_in_as(user)
      expect do
        delete :destroy, params: { id: fcase.id }
      end.to change(Fcase, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
