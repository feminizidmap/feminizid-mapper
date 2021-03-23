# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodelistController, type: :controller do
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let(:user) { FactoryBot.create(:user) }
  let!(:codelist) { FactoryBot.create(:codelist) }

  let(:valid_attributes) do
    { identifier: 2,
      name: 'Sexual orientation',
      lang: 'en',
      description: '' }
  end

  let(:invalid_attributes) do
    { identifier: 2,
      name: 'Sexual orientation',
      lang: 'eng',
      description: '' }
  end

  describe 'GET #index' do
    it 'allows users to receive codelists' do
      sign_in_as(user)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq codelist.id
    end
  end

  describe 'GET #show' do
    it 'allows user to receive a single codelist' do
      sign_in_as(user)
      get :show, params: { id: codelist.id }
      expect(response).to be_successful
      expect(response_json['id']).to eq codelist.id
    end
  end

  describe 'POST #create' do
    context 'with admin role' do
      context 'with valid params' do
        it 'creates a new Codelist' do
          sign_in_as(admin)
          expect do
            post :create, params: { codelist: valid_attributes }
          end.to change(Codelist, :count).by(1)
        end

        it 'renders a JSON response with the new codelist' do
          sign_in_as(admin)
          post :create, params: { codelist: valid_attributes }
          expect(response).to have_http_status(:created)
          expect(response.content_type).to include('application/json')
          expect(response_json['name']).to eq valid_attributes[:name]
          expect(response.location).to eq codelist_url(Codelist.last)
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the new codelist' do
          sign_in_as(admin)
          post :create, params: { codelist: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'with user role' do
      context 'with valid params' do
        it 'does not allow creation of new codelist' do
          sign_in_as(user)
          put :create, params: { codelist: valid_attributes }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'PUT #update' do
    let!(:codelist) { FactoryBot.create(:codelist) }

    context 'with admin role' do
      context 'with valid params' do
        let(:new_attributes) do
          { name: 'hello, this was changed' }
        end

        it 'updates the requested codelist' do
          sign_in_as(admin)
          put :update, params: { id: codelist.id, codelist: new_attributes }
          codelist.reload
          expect(codelist.name).to eq new_attributes[:name].to_s
        end

        it 'renders a JSON response with the codelist' do
          sign_in_as(admin)
          put :update, params: { id: codelist.id, codelist: new_attributes }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the change' do
          sign_in_as(admin)
          put :update, params: { id: codelist.id, codelist: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end

    context 'with user role' do
      context 'with valid params' do
        let(:new_attributes) do
          { name: 'hello, this was changed' }
        end

        it 'does not allow update' do
          sign_in_as(user)
          post :update, params: { id: codelist.id, codelist: new_attributes }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:codelist) { FactoryBot.create(:codelist) }

    context 'with admin role' do
      it 'destroys the requested codelist' do
        sign_in_as(admin)
        expect do
          delete :destroy, params: { id: codelist.id }
        end.to change(Codelist, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user role' do
      it 'does not destroy codelist' do
        sign_in_as(user)
        delete :destroy, params: { id: codelist.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
