# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Victim, type: :model do
  let(:fcase) { FactoryBot.create(:fcase) }

  it 'is valid with fcase' do
    victim = described_class.new(fcase: fcase)
    expect(victim).to be_valid
  end

  it 'is invalid without fcase' do
    victim = described_class.new
    victim.valid?
    expect(victim.errors[:fcase]).to include('must exist')
  end

  it 'belongs to fcase' do
    v = described_class.reflect_on_association(:fcase)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for drunk' do
    victim = described_class.new(drunk_attributes: { answer: 'yes' }, fcase: fcase)
    expect(victim).to be_valid
    victim.save
    expect(victim.drunk.answer).to eq('yes')
  end

  it 'belongs to a drunk answer (YesNo)' do
    v = described_class.reflect_on_association(:drunk)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for drug_influence' do
    victim = described_class.new(drug_influence_attributes: { answer: 'yes' }, fcase: fcase)
    expect(victim).to be_valid
    victim.save
    expect(victim.drug_influence.answer).to eq('yes')
  end

  it 'belongs to a drug influence answer (YesNo)' do
    v = described_class.reflect_on_association(:drug_influence)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for previous reports of violence' do
    victim = described_class.new(previous_reports_of_violence_attributes: { answer: 'yes' }, fcase: fcase)
    expect(victim).to be_valid
    victim.save
    expect(victim.previous_reports_of_violence.answer).to eq('yes')
  end

  it 'belongs to a previous report of violence answer (YesNo)' do
    v = described_class.reflect_on_association(:previous_reports_of_violence)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts a civil status' do
    codelist = Codelist.new(
      identifier: 1,
      name: 'Civil status',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'married',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(civil_status: item, fcase: fcase)
    v.save
    expect(v.civil_status.name).to eq('married')
  end

  it 'accepts an educational background' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Educational Background',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Bachelor',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(educational_background: item, fcase: fcase)
    v.save
    expect(v.educational_background.name).to eq('Bachelor')
  end

  it 'accepts a citizenship type' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Citizenship type',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Double (German and foreign)',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(citizenship_type: item, fcase: fcase)
    v.save
    expect(v.citizenship_type.name).to eq('Double (German and foreign)')
  end

  it 'accepts a legal status' do
    codelist = Codelist.new(
      identifier: 2,
      name: 'Legal status',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'Visa',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(legal_status: item, fcase: fcase)
    v.save
    expect(v.legal_status.name).to eq('Visa')
  end

  describe '.by_drunk_answer' do
    it 'includes victims with given answer' do
      victim = described_class.create!(drunk_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_drunk_answer(:yes)).to include(victim)
    end

    it 'excludes victims without given answer' do
      victim = described_class.create!(drunk_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_drunk_answer(:yes)).not_to include(victim)
    end
  end

  describe '.by_drug_answer' do
    it 'includes victims with given answer' do
      victim = described_class.create!(drug_influence_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_drug_answer(:yes)).to include(victim)
    end

    it 'excludes victims without given answer' do
      victim = described_class.create!(drug_influence_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_drug_answer(:yes)).not_to include(victim)
    end
  end

  describe '.by_reports_answer' do
    it 'includes victims with given answer' do
      victim = described_class.create!(previous_reports_of_violence_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_reports_answer(:yes)).to include(victim)
    end

    it 'excludes victims without given answer' do
      victim = described_class.create!(previous_reports_of_violence_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_reports_answer(:yes)).not_to include(victim)
    end
  end

  describe '.by_civil_status' do
    it 'includes victims with given status' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Civil status',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'married',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(civil_status: item, fcase: fcase)
      expect(described_class.by_civil_status('married')).to include(v)
    end

    it 'excludes victims without given status' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Civil status',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'married',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(civil_status: item, fcase: fcase)
      expect(described_class.by_civil_status('single')).not_to include(v)
    end
  end

  describe '.by_educational_background' do
    it 'includes victims with given background' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Educational background',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'highschool',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(educational_background: item, fcase: fcase)
      expect(described_class.by_educational_background('highschool')).to include(v)
    end

    it 'excludes victims without given background' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Educational background',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'highschool',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(educational_background: item, fcase: fcase)
      expect(described_class.by_educational_background('masters')).not_to include(v)
    end
  end

  describe '.by_citizenship_type' do
    it 'includes victims with given type' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Citizenship type',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'German',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(citizenship_type: item, fcase: fcase)
      expect(described_class.by_citizenship_type('German')).to include(v)
    end

    it 'excludes victims without given type' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Citizenship type',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'German',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(citizenship_type: item, fcase: fcase)
      expect(described_class.by_citizenship_type('Double (German and foreign)')).not_to include(v)
    end
  end

  describe '.by_legal_status' do
    it 'includes victims with given status' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Legal status',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'Undocumented',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(legal_status: item, fcase: fcase)
      expect(described_class.by_legal_status('Undocumented')).to include(v)
    end

    it 'excludes victims without given status' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Legal status',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'Undocumented',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(legal_status: item, fcase: fcase)
      expect(described_class.by_legal_status('Visa')).not_to include(v)
    end
  end
end
