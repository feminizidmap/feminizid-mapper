# frozen_string_literal: true

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  before { sign_in_as(user) }

  describe 'GET #me' do
    it 'returns a success response' do
      get :me
      expect(response).to be_successful
      expect(response_json).to eq user.as_json
    end
  end

  describe 'PUT #update' do
    it 'allows user to update their email and password' do
      put :update, params: { id: user.to_param, user: { email: 'new@mail.org' } }
      expect(response).to have_http_status(:ok)
      expect(user.reload.email).to eq('new@mail.org')
    end

    it "does not allow user to update other's email and password" do
      user2 = create(:user)
      put :update, params: { id: user2.to_param, user: { email: 'new@mail.org' } }
      expect(response).to have_http_status(:forbidden)
      expect(user2.reload.email).not_to eq('new@mail.org')
    end

    it 'does not allow user to update role' do
      expect(user.role).to eq('user')
      put :update, params: { id: user.to_param, user: { role: 'admin' } }
      expect(user.reload.role).to eq('user')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'allows user to delete themself' do
      expect(User.count).to be(1)
      delete :destroy, params: { id: user.id }
      expect(response).to be_successful
      expect(User.count).to be(0)
    end

    it 'does not allow user to delete another user' do
      user2 = create(:user)
      expect(User.count).to be(2)
      delete :destroy, params: { id: user2.id }
      expect(response).not_to be_successful
      expect(User.count).to be(2)
    end
  end
end
