# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Crime, type: :model do
  let(:fcase) { FactoryBot.create(:fcase) }

  it 'is valid with fcase' do
    crime = described_class.new(fcase: fcase)
    expect(crime).to be_valid
  end

  it 'is invalid without fcase' do
    crime = described_class.new
    crime.valid?
    expect(crime.errors[:fcase]).to include('must exist')
  end

  it 'belongs to fcase' do
    v = described_class.reflect_on_association(:fcase)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'has many victims' do
    v = described_class.reflect_on_association(:victims)
    expect(v.macro).to eq(:has_many)
  end

  it 'has many perpetrators' do
    v = described_class.reflect_on_association(:perpetrators)
    expect(v.macro).to eq(:has_many)
  end

  it 'accepts a location' do
    codelist = Codelist.new(
      identifier: 1,
      name: 'Location',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: "victim's apartment",
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(location: item, fcase: fcase)
    v.save
    expect(v.location.name).to eq("victim's apartment")
  end

  it 'accepts a cause of death' do
    codelist = Codelist.new(
      identifier: 1,
      name: 'Cause of Death',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Strangling',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(cause_of_death: item, fcase: fcase)
    v.save
    expect(v.cause_of_death.name).to eq('Strangling')
  end

  it 'accepts acts of violence' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Acts of Violence',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Bruises',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(acts_of_violence: item, fcase: fcase)
    v.save
    expect(v.acts_of_violence.name).to eq('Bruises')
  end

  it 'accepts weapons' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Weapons',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Knife',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(weapons: item, fcase: fcase)
    v.save
    expect(v.weapons.name).to eq('Knife')
  end

  it 'accepts a feminicide type' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Feminicide Type',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Intimid',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(ftype: item, fcase: fcase)
    v.save
    expect(v.ftype.name).to eq('Intimid')
  end

  it 'accepts a motif' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Motif',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Jealousy',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(motif: item, fcase: fcase)
    v.save
    expect(v.motif.name).to eq('Jealousy')
  end

  describe '.by_location' do
    it 'includes crimes with given location' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Location',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: "victim's apartment",
        description: '',
        lang: 'en'
      )
      v = described_class.create!(location: item, fcase: fcase)
      expect(described_class.by_location("victim's apartment")).to include(v)
    end

    it 'excludes crimes without given location' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Location',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: "victim's apartment",
        description: '',
        lang: 'en'
      )
      v = described_class.create!(location: item, fcase: fcase)
      expect(described_class.by_location('perpetrators apartment')).not_to include(v)
    end
  end
end
