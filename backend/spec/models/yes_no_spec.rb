# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YesNo, type: :model do
  it 'is valid with answer' do
    yn = described_class.new(answer: :yes)
    expect(yn).to be_valid
  end

  it 'is invalid without answer' do
    yn = described_class.new
    yn.valid?
    expect(yn.errors[:answer]).to include("can't be blank")
  end
end
