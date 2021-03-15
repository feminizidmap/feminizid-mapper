# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with email and password' do
    user = described_class.new(
      email: 'test@test.xyz',
      password: 'hayahey'
    )
    expect(user).to be_valid
  end

  it 'invalid without email' do
    user = described_class.new(password: 'heyahey')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'invalid without password' do
    user = described_class.new(email: 'test@test.xyz')
    user.valid?
    expect(user.errors[:password_digest]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    described_class.create(email: 'test@test.de', password: 'hey')
    user = described_class.create(email: 'test@test.de', password: 'heyahey')
    user.valid?
    expect(user.errors[:email]).to include('has already been taken')
  end
end
