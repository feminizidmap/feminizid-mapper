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
end
