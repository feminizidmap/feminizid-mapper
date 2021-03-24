# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SystemSetting, type: :model do
  it 'is valid with key and value' do
    setting = described_class.new(
      key: 'setting_lang',
      value: %w[en de]
    )
    expect(setting).to be_valid
  end

  it 'is invalid without key' do
    setting = described_class.new(
      value: %w[en de]
    )
    setting.valid?
    expect(setting.errors[:key]).to include("can't be blank")
  end

  it 'is invalid without value' do
    setting = described_class.new(
      key: 'setting_lang'
    )
    setting.valid?
    expect(setting.errors[:value]).to include("can't be blank")
  end
end
