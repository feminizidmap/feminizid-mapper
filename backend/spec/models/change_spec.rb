# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Change, type: :model do
  it 'is valid with user and status' do
    user = FactoryBot.create(:user)
    change = described_class.create(status: :created, user: user)
    expect(change).to be_valid
  end

  it 'is invalid without user' do
    change = described_class.create(status: :created)
    change.valid?
    expect(change.errors[:user]).to include('must exist')
  end

  it 'is invalid with invalid status' do
    user = FactoryBot.create(:user)
    expect { described_class.create(user: user, status: :foo) }.to raise_error(ArgumentError, /valid status/)
  end

  it 'is invalid without status' do
    user = FactoryBot.create(:user)
    expect { described_class.create(user: user) }.to raise_error(ActiveRecord::NotNullViolation, /null value/)
  end
end
