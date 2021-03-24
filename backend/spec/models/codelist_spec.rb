# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codelist, type: :model do
  it 'is valid with identifier, name and language' do
    codelist = described_class.new(
      identifier: 1,
      name: 'Gender Identity',
      lang: 'en'
    )
    expect(codelist).to be_valid
  end

  it 'has many codelist items' do
    t = described_class.reflect_on_association(:codelist_items)
    expect(t.macro).to eq(:has_many)
  end

  it 'is invalid without identifier' do
    codelist = described_class.new(
      name: 'Gender Identity',
      lang: 'en'
    )
    codelist.valid?
    expect(codelist.errors[:identifier]).to include("can't be blank")
  end

  it 'is invalid without name' do
    codelist = described_class.new(
      identifier: 1,
      lang: 'en'
    )
    codelist.valid?
    expect(codelist.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without language' do
    codelist = described_class.new(
      identifier: 1,
      name: 'Gender Identity'
    )
    codelist.valid?
    expect(codelist.errors[:lang]).to include("can't be blank")
  end

  it 'is invalid if language code is too long' do
    codelist = described_class.new(
      identifier: 1,
      name: 'Gender Identity',
      lang: 'eng'
    )
    codelist.valid?
    expect(codelist.errors[:lang]).to include('is the wrong length (should be 2 characters)')
  end

  it 'is invalid if language is not present in language list' do
    codelist = described_class.new(
      identifier: 1,
      name: 'Gender Identity',
      lang: 'xx'
    )
    codelist.valid?
    expect(codelist.errors[:lang][0]).to include('does not exist')
  end

  describe '.by_language' do
    it 'includes codes with given language' do
      codelist = described_class.create!(identifier: 1, name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_language('en')).to include(codelist)
    end

    it 'excludes codes without given language' do
      codelist = described_class.create!(identifier: 1, name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_language('de')).not_to include(codelist)
    end
  end

  describe '.by_code' do
    it 'includes codes with given code' do
      codelist = described_class.create!(identifier: 1, name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_identifier(1)).to include(codelist)
    end

    it 'excludes codes without given code' do
      codelist = described_class.create!(identifier: 1, name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_identifier(2)).not_to include(codelist)
    end
  end
end
