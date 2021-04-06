# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Victim, type: :model do
  it 'is valid without any fields' do
    victim = described_class.new
    expect(victim).to be_valid
  end

  it 'accepts nested attributes' do
    victim = described_class.new(drunk_attributes: { answer: 'yes' })
    expect(victim).to be_valid
    victim.save
    expect(victim.drunk.answer).to eq('yes')
  end
end
