# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SystemSettingsController, type: :controller do
  let(:admin) { create(:user, role: :admin) }
  let(:user) { create(:user, role: :user) }
  let!(:system_setting) { create(:system_setting) }

  let(:valid_attributes) do
    { key: 'settings_numbers',
      value: [1, 2, 3, 4].to_json }
  end

  let(:invalid_attributes) do
    { key: '' }
  end

  describe 'GET #index' do
    context 'with admin role' do
      it 'allows admin to receive system settings' do
        sign_in_as(admin)
        get :index
        expect(response).to be_successful
        expect(response_json.size).to eq 1
        expect(response_json.first['id']).to eq system_setting.id
      end
    end

    context 'with user role' do
      it 'does not allow user to receive system settings' do
        sign_in_as(user)
        get :index
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET #show' do
    context 'with admin role' do
      it 'allows admin to receive single system settings' do
        sign_in_as(admin)
        get :show, params: { id: system_setting.id }
        expect(response).to be_successful
        expect(response_json['id']).to eq system_setting.id
      end
    end

    context 'with user role' do
      it 'does not allow user to receive single system settings' do
        sign_in_as(user)
        get :show, params: { id: system_setting.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST #create' do
    context 'with admin role' do
      context 'with valid params' do
        it 'creates a new system_setting' do
          sign_in_as(admin)
          expect do
            post :create, params: { system_setting: valid_attributes }
          end.to change(SystemSetting, :count).by(1)
        end

        it 'renders a JSON response with the new systemsetting' do
          sign_in_as(admin)
          post :create, params: { system_setting: valid_attributes }
          expect(response).to have_http_status(:created)
          expect(response.content_type).to include('application/json')
          expect(response_json['key']).to eq valid_attributes[:key]
          expect(response.location).to eq system_setting_url(SystemSetting.last)
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the new system setting' do
          sign_in_as(admin)
          post :create, params: { system_setting: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'with user role' do
      context 'with valid params' do
        it 'does not allow creation of new system_setting' do
          sign_in_as(user)
          put :create, params: { system_setting: valid_attributes }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'PUT #update' do
    let!(:system_setting) { create(:system_setting) }
    let(:new_attributes) do
      { value: [3, 4, 5].to_json }
    end

    context 'with admin role' do
      context 'with valid params' do
        it 'updates the requested system setting' do
          sign_in_as(admin)
          put :update, params: { id: system_setting.id, system_setting: new_attributes }
          system_setting.reload
          expect(system_setting.value).to eq new_attributes[:value]
        end

        it 'renders a JSON response with the system setting' do
          sign_in_as(admin)
          put :update, params: { id: system_setting.id, system_setting: new_attributes }
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end

      context 'with invalid params' do
        it 'renders a JSON response with errors for the system setting' do
          sign_in_as(admin)
          put :update, params: { id: system_setting.id, system_setting: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json; charset=utf-8')
        end
      end
    end

    context 'with user role' do
      context 'with valid params' do
        let(:new_attributes) do
          { value: [5, 6, 7] }
        end

        it 'does not allow update' do
          sign_in_as(user)
          put :update, params: { id: system_setting.id, system_setting: new_attributes }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:system_setting) { create(:system_setting) }

    context 'with admin role' do
      it 'destroys the requested system_setting' do
        sign_in_as(admin)
        expect do
          delete :destroy, params: { id: system_setting.id }
        end.to change(SystemSetting, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with user role' do
      it 'does not destroy system setting' do
        sign_in_as(user)
        delete :destroy, params: { id: system_setting.id }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
