# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PerpetratorController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:fcase) { FactoryBot.create(:fcase) }
  let!(:perpetrator) { FactoryBot.create(:perpetrator, fcase: fcase) }

  let(:valid_attributes) do
    { age: 28,
      fcase_id: fcase.id }
  end

  describe 'GET #index' do
    it 'allows users to receive perpetrators' do
      sign_in_as(user)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json['data'].first['id']).to eq perpetrator.id
    end
  end

  describe 'GET #show' do
    it 'allows user to receive a single perpetrator' do
      sign_in_as(user)
      get :show, params: { id: perpetrator.id }
      expect(response).to be_successful
      expect(response_json['data']['id']).to eq perpetrator.id
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Perpetrator' do
        sign_in_as(user)
        expect do
          post :create, params: { perpetrator: valid_attributes }
        end.to change(Perpetrator, :count).by(1)
      end

      it 'renders a JSON response with the new perpetrator' do
        sign_in_as(user)
        post :create, params: { perpetrator: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to include('application/json')
        expect(response_json['age']).to eq valid_attributes[:age]
        expect(response.location).to eq perpetrator_url(Perpetrator.last)
      end
    end
  end

  describe 'PUT #update' do
    let!(:perpetrator) { FactoryBot.create(:perpetrator, fcase: fcase) }

    context 'with valid params' do
      let(:new_attributes) do
        { ident: '2021-04-30-foo' }
      end

      it 'updates the requested perpetrator' do
        sign_in_as(user)
        put :update, params: { id: perpetrator.id, perpetrator: new_attributes }
        perpetrator.reload
        expect(perpetrator.age).to eq new_attributes[:age]
      end

      it 'renders a JSON response with the perpetrator' do
        sign_in_as(user)
        put :update, params: { id: perpetrator.id, perpetrator: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:perpetrator) { FactoryBot.create(:perpetrator, fcase: fcase) }

    it 'destroys the requested perpetrator' do
      sign_in_as(user)
      expect do
        delete :destroy, params: { id: perpetrator.id }
      end.to change(Perpetrator, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
