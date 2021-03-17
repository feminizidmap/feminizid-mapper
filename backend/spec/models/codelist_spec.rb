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
end
