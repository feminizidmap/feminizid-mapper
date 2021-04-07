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

  describe '.is_yes' do
    it 'includes everything with yes' do
      yn = described_class.create!(answer: :yes)
      expect(described_class.is_yes).to include(yn)
    end

    it 'excludes everything without yes' do
      yn = described_class.create!(answer: :no)
      expect(described_class.is_yes).not_to include(yn)
    end
  end

  describe '.is_no' do
    it 'includes everything with no' do
      yn = described_class.create!(answer: :no)
      expect(described_class.is_no).to include(yn)
    end

    it 'excludes everything without no' do
      yn = described_class.create!(answer: :unknown)
      expect(described_class.is_no).not_to include(yn)
    end
  end

  describe '.is_unknown' do
    it 'includes everything with unknown' do
      yn = described_class.create!(answer: :unknown)
      expect(described_class.is_unknown).to include(yn)
    end

    it 'excludes everything without no' do
      yn = described_class.create!(answer: :yes)
      expect(described_class.is_unknown).not_to include(yn)
    end
  end

  describe '.is_not_applicable' do
    it 'includes everything with not_applicable' do
      yn = described_class.create!(answer: :not_applicable)
      expect(described_class.is_not_applicable).to include(yn)
    end

    it 'excludes everything without no' do
      yn = described_class.create!(answer: :no)
      expect(described_class.is_not_applicable).not_to include(yn)
    end
  end

  describe '.is()' do
    it 'includes everything with parameter' do
      yn = described_class.create!(answer: :no)
      expect(described_class.is(:no)).to include(yn)
    end
    it 'excludes everything without parameter' do
      yn = described_class.create!(answer: :unknown)
      expect(described_class.is(:no)).not_to include(yn)
    end
  end
end
