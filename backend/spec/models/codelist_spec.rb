# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Codelist, type: :model do
  it 'is valid with code, name and language' do
    codelist = described_class.new(
      code: 'gender_identity',
      name: 'Cis Male',
      lang: 'en'
    )
    expect(codelist).to be_valid
  end

  it 'is invalid without code' do
    codelist = described_class.new(
      name: 'Cis Male',
      lang: 'en'
    )
    codelist.valid?
    expect(codelist.errors[:code]).to include("can't be blank")
  end

  it 'is invalid without name' do
    codelist = described_class.new(
      code: 'gender_identity',
      lang: 'en'
    )
    codelist.valid?
    expect(codelist.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without language' do
    codelist = described_class.new(
      code: 'gender_identity',
      name: 'Cis Male'
    )
    codelist.valid?
    expect(codelist.errors[:lang]).to include("can't be blank")
  end

  it 'is invalid if language code is too long' do
    codelist = described_class.new(
      code: 'gender_identity',
      name: 'Cis Male',
      lang: 'eng'
    )
    codelist.valid?
    expect(codelist.errors[:lang]).to include('is the wrong length (should be 2 characters)')
  end

  it 'is invalid if language is not present in language list' do
    codelist = described_class.new(
      code: 'gender_identity',
      name: 'Cis Male',
      lang: 'xx'
    )
    codelist.valid?
    expect(codelist.errors[:lang][0]).to include('does not exist')
  end

  describe '.by_language' do
    it 'includes codes with given language' do
      codelist = described_class.create!(code: 'gender_identity', name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_language('en')).to include(codelist)
    end

    it 'excludes codes without given language' do
      codelist = described_class.create!(code: 'gender_identity', name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_language('de')).not_to include(codelist)
    end
  end

  describe '.by_code' do
    it 'includes codes with given code' do
      codelist = described_class.create!(code: 'gender_identity', name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_code('gender_identity')).to include(codelist)
    end

    it 'excludes codes without given code' do
      codelist = described_class.create!(code: 'gender_identity', name: 'Cis Male', lang: 'en', description: '')
      expect(described_class.by_code('sexual_orientation')).not_to include(codelist)
    end
  end
end
