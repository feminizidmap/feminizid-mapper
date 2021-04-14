# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CodelistItem, type: :model do
  let(:codelist) { FactoryBot.create(:codelist) }

  it 'belongs to codelist' do
    t = described_class.reflect_on_association(:codelist)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'is valid with codelist, identifier, name, description and language' do
    codelist_item = described_class.new(
      codelist: codelist,
      identifier: 2,
      name: 'Cis Male',
      description: '',
      lang: 'en'
    )
    expect(codelist_item).to be_valid
  end

  it 'is invalid without codelist' do
    codelist_item = described_class.new(
      identifier: 2,
      name: 'Cis Male',
      description: '',
      lang: 'en'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:codelist]).to include('must exist')
  end

  it 'is invalid without identifier' do
    codelist_item = described_class.new(
      codelist: codelist,
      name: 'Cis Male',
      description: '',
      lang: 'en'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:identifier]).to include("can't be blank")
  end

  it 'is invalid without name' do
    codelist_item = described_class.new(
      codelist: codelist,
      identifier: 2,
      description: '',
      lang: 'en'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:name]).to include("can't be blank")
  end

  it 'is invalid without description' do
    codelist_item = described_class.new(
      codelist: codelist,
      name: 'foo',
      identifier: 2,
      lang: 'en'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:description]).to include("can't be nil")
  end

  it 'is invalid without language' do
    codelist_item = described_class.new(
      codelist: codelist,
      identifier: 2,
      name: 'Cis Male'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:lang]).to include("can't be blank")
  end

  it 'is invalid if language code is too long' do
    codelist_item = described_class.new(
      codelist: codelist,
      identifier: 2,
      description: '',
      name: 'Cis Male',
      lang: 'eng'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:lang]).to include('is the wrong length (should be 2 characters)')
  end

  it 'is invalid if language is not present in language list' do
    codelist_item = described_class.new(
      codelist: codelist,
      identifier: 2,
      name: 'Cis Male',
      description: '',
      lang: 'xx'
    )
    codelist_item.valid?
    expect(codelist_item.errors[:lang][0]).to include('does not exist')
  end

  describe '.by_language' do
    it 'includes codes with given language' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Cis Male',
                                              lang: 'en',
                                              description: '')
      expect(described_class.by_language('en')).to include(codelist_item)
    end

    it 'excludes codes without given language' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Cis Male',
                                              lang: 'en', description: '')
      expect(described_class.by_language('de')).not_to include(codelist_item)
    end
  end

  describe '.by_identifier' do
    it 'includes codes with given identifier' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Cis Male',
                                              lang: 'en', description: '')
      expect(described_class.by_identifier(2)).to include(codelist_item)
    end

    it 'excludes codes without given identifier' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Cis Male',
                                              lang: 'en', description: '')
      expect(described_class.by_identifier(1)).not_to include(codelist_item)
    end
  end

  describe '.by_name' do
    it 'includes codes with given name' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Test',
                                              lang: 'en', description: '')
      expect(described_class.by_name('Test')).to include(codelist_item)
    end

    it 'excludes codes without given name' do
      codelist_item = described_class.create!(codelist: codelist,
                                              identifier: 2,
                                              name: 'Cis Male',
                                              lang: 'en', description: '')
      expect(described_class.by_name('Test')).not_to include(codelist_item)
    end
  end
end
