# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CrimeController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:fcase) { FactoryBot.create(:fcase) }
  let!(:crime) { FactoryBot.create(:crime, fcase: fcase) }

  let(:valid_attributes) do
    { address: "Backstreet's Back",
      fcase_id: fcase.id }
  end

  describe 'GET #index' do
    it 'allows users to receive crimes' do
      sign_in_as(user)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json['data'].first['id']).to eq crime.id
    end
  end

  describe 'GET #show' do
    it 'allows user to receive a single crime' do
      sign_in_as(user)
      get :show, params: { id: crime.id }
      expect(response).to be_successful
      expect(response_json['data']['id']).to eq crime.id
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Crime' do
        sign_in_as(user)
        expect do
          post :create, params: { crime: valid_attributes }
        end.to change(Crime, :count).by(1)
      end

      it 'renders a JSON response with the new crime' do
        sign_in_as(user)
        post :create, params: { crime: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response_json['address']).to eq valid_attributes[:address]
        expect(response.location).to eq crime_url(Crime.last)
      end
    end
  end

  describe 'PUT #update' do
    let!(:crime) { FactoryBot.create(:crime, fcase: fcase) }

    context 'with valid params' do
      let(:new_attributes) do
        { ident: '2021-04-30-foo' }
      end

      it 'updates the requested crime' do
        sign_in_as(user)
        put :update, params: { id: crime.id, crime: new_attributes }
        crime.reload
        expect(crime.address).to eq new_attributes[:address]
      end

      it 'renders a JSON response with the crime' do
        sign_in_as(user)
        put :update, params: { id: crime.id, crime: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:crime) { FactoryBot.create(:crime, fcase: fcase) }

    it 'destroys the requested crime' do
      sign_in_as(user)
      expect do
        delete :destroy, params: { id: crime.id }
      end.to change(Crime, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
