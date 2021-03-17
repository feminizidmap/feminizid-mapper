# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodelistsController, type: :controller do
  let(:admin) { FactoryBot.create(:user, role: :admin) }
  let(:user) { FactoryBot.create(:user) }
  let!(:codelist) { FactoryBot.create(:codelist) }

  let(:valid_attributes) do
    { code: :gender_identity,
      name: 'Cis Female',
      lang: 'en',
      description: '' }
  end

  let(:invalid_attributes) do
    { code: :gender_identity,
      lang: 'eng',
      description: '' }
  end

  describe 'GET #index' do
    it 'allows users to receive codelists' do
      sign_in_as(admin)
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq codelist.id
    end

    it 'unauth without cookie' do
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET #show' do
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Codelist' do
      end

      it 'renders a JSON response with the new codelist' do
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new codelist' do
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested codelist' do
      end

      it 'renders a JSON response with the codelist' do
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the change' do
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested change' do
    end
  end
end
