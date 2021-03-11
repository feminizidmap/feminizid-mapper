# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::Users::ChangesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:reviewer) { FactoryBot.create(:user, role: :reviewer) }
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let!(:change) { FactoryBot.create(:change, user: user) }
  # let!(:change2) { FactoryBot.create(:change, user: reviewer) }

  describe 'GET #index' do
    it 'allows admin to receive changes list' do
      sign_in_as(admin)
      get :index, params: { user_id: user.id }
      # pry
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq change.id
    end

    it 'does not allow reviewer to receive changes list' do
      sign_in_as(reviewer)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:forbidden)
    end

    it 'does not allow regular user to receive changes list' do
      sign_in_as(user)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:forbidden)
    end
  end
end
