# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:reviewer) { FactoryBot.create(:user, role: :reviewer) }
  let!(:admin) { FactoryBot.create(:user, role: :admin) }

  describe 'GET #index' do
    it 'allows admin to receive users list' do
      sign_in_as(admin)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 3
    end

    it 'allows reviewer to receive users list' do
      sign_in_as(reviewer)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 3
    end

    it 'does not allow regular user to receive users list' do
      sign_in_as(user)
      get :index
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'GET #show' do
    it 'allows admin to get a user' do
      sign_in_as(admin)
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'allows reviewer to get a user' do
      sign_in_as(reviewer)
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end

    it 'does not allow regular user to get a user' do
      sign_in_as(user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'PATCH #update' do
    it 'allows admin to update a user' do
      sign_in_as(admin)
      patch :update, params: { id: user.id, user: { role: :reviewer } }
      expect(response).to be_successful
      expect(user.reload.role).to eq 'reviewer'
    end

    it 'does not allow reviewer to update a user' do
      sign_in_as(reviewer)
      patch :update, params: { id: user.id, user: { role: :reviewer } }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not allow user to update a user' do
      sign_in_as(user)
      patch :update, params: { id: user.id, user: { role: :reviewer } }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not allow admin to update their own role' do
      sign_in_as(admin)
      patch :update, params: { id: admin.id, user: { role: :user } }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'DELETE #destroy' do
    it 'allows admin to delete user' do
      sign_in_as(admin)
      expect(User.count).to be(3)
      delete :destroy, params: { id: user.id }
      expect(response).to be_successful
      expect(User.count).to be(2)
    end

    it 'does not allow reviewer to delete user' do
      sign_in_as(reviewer)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not allow user to delete user' do
      sign_in_as(user)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
