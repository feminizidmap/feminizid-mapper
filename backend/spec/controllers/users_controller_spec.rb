# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in_as(user) }

  describe 'GET #me' do
    # let!(:todo) { create(:todo, user: user) }

    it 'returns a success response' do
      get :me
      expect(response).to be_successful
      expect(response_json).to eq user.as_json
    end
  end
end
