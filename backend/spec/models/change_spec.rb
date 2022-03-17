# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Change, type: :model do
  it 'is valid with user, record and status' do
    user = create(:user)
    record = create(:record)
    change = described_class.create(status: :created, user: user, record: record)
    expect(change).to be_valid
  end

  it 'is invalid without user' do
    record = create(:record)
    change = described_class.create(status: :created, record: record)
    change.valid?
    expect(change.errors[:user]).to include('must exist')
  end

  it 'is invalid without record' do
    user = create(:user)
    change = described_class.create(status: :created, user: user)
    change.valid?
    expect(change.errors[:record]).to include('must exist')
  end

  it 'is invalid with invalid status' do
    user = create(:user)
    record = create(:record)
    expect { described_class.create(user: user, record: record, status: :foo) }.to raise_error(ArgumentError, /valid status/)
  end

  it 'is invalid without status' do
    record = create(:record)
    user = create(:user)
    expect { described_class.create(user: user, record: record) }.to raise_error(ActiveRecord::NotNullViolation, /null value/)
  end
end
