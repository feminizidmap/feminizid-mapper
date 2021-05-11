# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Perpetrator, type: :model do
  let(:fcase) { FactoryBot.create(:fcase) }

  it 'is valid with fcase' do
    perpetrator = described_class.new(fcase: fcase)
    expect(perpetrator).to be_valid
  end

  it 'is invalid without fcase' do
    perpetrator = described_class.new
    perpetrator.valid?
    expect(perpetrator.errors[:fcase]).to include('must exist')
  end

  it 'belongs to fcase' do
    v = described_class.reflect_on_association(:fcase)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for alcohol influence' do
    perpetrator = described_class.new(alcohol_influence_attributes: { answer: 'yes' }, fcase: fcase)
    expect(perpetrator).to be_valid
    perpetrator.save
    expect(perpetrator.alcohol_influence.answer).to eq('yes')
  end

  it 'belongs to a alcohol influence answer (YesNo)' do
    v = described_class.reflect_on_association(:alcohol_influence)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for drug_influence' do
    perpetrator = described_class.new(drug_influence_attributes: { answer: 'yes' }, fcase: fcase)
    expect(perpetrator).to be_valid
    perpetrator.save
    expect(perpetrator.drug_influence.answer).to eq('yes')
  end

  it 'belongs to a drug influence answer (YesNo)' do
    v = described_class.reflect_on_association(:drug_influence)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for previous psychological condition' do
    perpetrator = described_class.new(previous_psychological_condition_attributes: { answer: 'yes' }, fcase: fcase)
    expect(perpetrator).to be_valid
    perpetrator.save
    expect(perpetrator.previous_psychological_condition.answer).to eq('yes')
  end

  it 'belongs to previous psychological condition (YesNo)' do
    v = described_class.reflect_on_association(:previous_psychological_condition)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for previous criminal record' do
    perpetrator = described_class.new(previous_criminal_record_attributes: { answer: 'yes' }, fcase: fcase)
    expect(perpetrator).to be_valid
    perpetrator.save
    expect(perpetrator.previous_criminal_record.answer).to eq('yes')
  end

  it 'belongs to previous criminal record (YesNo)' do
    v = described_class.reflect_on_association(:previous_criminal_record)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts nested attributes for suicide afterwards' do
    perpetrator = described_class.new(suicide_afterwards_attributes: { answer: 'yes' }, fcase: fcase)
    expect(perpetrator).to be_valid
    perpetrator.save
    expect(perpetrator.suicide_afterwards.answer).to eq('yes')
  end

  it 'belongs to suicide afterwards (YesNo)' do
    v = described_class.reflect_on_association(:suicide_afterwards)
    expect(v.macro).to eq(:belongs_to)
  end

  it 'accepts a gender' do
    codelist = Codelist.new(
      identifier: 1,
      name: 'Gender',
      lang: 'en'
    )
    codelist.save
    item = codelist.items.new(
      identifier: 2,
      name: 'cis male',
      description: '',
      lang: 'en'
    )
    item.save

    v = described_class.new(gender: item, fcase: fcase)
    v.save
    expect(v.gender.name).to eq('cis male')
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

  describe '.by_alcohol_answer' do
    it 'includes perpetrators with given answer' do
      perpetrator = described_class.create!(alcohol_influence_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_alcohol_answer(:yes)).to include(perpetrator)
    end

    it 'excludes perpetrators without given answer' do
      perpetrator = described_class.create!(alcohol_influence_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_alcohol_answer(:yes)).not_to include(perpetrator)
    end
  end

  describe '.by_drug_answer' do
    it 'includes perpetrators with given answer' do
      perpetrator = described_class.create!(drug_influence_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_drug_answer(:yes)).to include(perpetrator)
    end

    it 'excludes perpetrators without given answer' do
      perpetrator = described_class.create!(drug_influence_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_drug_answer(:yes)).not_to include(perpetrator)
    end
  end

  describe '.by_psychological_condition_answer' do
    it 'includes perpetrators with given answer' do
      perpetrator = described_class.create!(previous_psychological_condition_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_pyschological_condition_answer(:yes)).to include(perpetrator)
    end

    it 'excludes perpetrators without given answer' do
      perpetrator = described_class.create!(previous_psychological_condition_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_pyschological_condition_answer(:yes)).not_to include(perpetrator)
    end
  end

  describe '.by_criminal_record' do
    it 'includes perpetrators with given answer' do
      perpetrator = described_class.create!(previous_criminal_record_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_criminal_record_answer(:yes)).to include(perpetrator)
    end

    it 'excludes perpetrators without given answer' do
      perpetrator = described_class.create!(previous_criminal_record_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_criminal_record_answer(:yes)).not_to include(perpetrator)
    end
  end

  describe '.by_suicide_afterwards_answer' do
    it 'includes perpetrators with given answer' do
      perpetrator = described_class.create!(suicide_afterwards_attributes: { answer: 'yes' }, fcase: fcase)
      expect(described_class.by_suicide_answer(:yes)).to include(perpetrator)
    end

    it 'excludes perpetrators without given answer' do
      perpetrator = described_class.create!(suicide_afterwards_attributes: { answer: 'no' }, fcase: fcase)
      expect(described_class.by_suicide_answer(:yes)).not_to include(perpetrator)
    end
  end

  describe '.by_gender' do
    it 'includes perpetrators with given gender' do
      codelist = Codelist.create!(
        identifier: 1,
        name: 'Gender',
        lang: 'en'
      )
      item = codelist.items.create!(
        identifier: 2,
        name: 'cis male',
        description: '',
        lang: 'en'
      )
      v = described_class.create!(gender: item, fcase: fcase)
      expect(described_class.by_gender('cis male')).to include(v)
    end

    it 'excludes perpetrators without given status' do
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

  describe '.by_civil_status' do
    it 'includes perpetrators with given status' do
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

    it 'excludes perpetrators without given status' do
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
    it 'includes perpetrators with given background' do
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

    it 'excludes perpetrators without given background' do
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
    it 'includes perpetrators with given type' do
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

    it 'excludes perpetrators without given type' do
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
    it 'includes perpetrators with given status' do
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

    it 'excludes perpetrators without given status' do
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
