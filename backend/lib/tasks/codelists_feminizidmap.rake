# frozen_string_literal: true

namespace :codelists do
  namespace :feminizidmap do
    desc 'Import default codelists as used by feminizidmap.org'
    task add_default: :environment do
      Rake::Task['codelists:feminizidmap:add_media_label'].execute
      Rake::Task['codelists:feminizidmap:add_civil_status'].execute
      Rake::Task['codelists:feminizidmap:add_educational_background'].execute
      Rake::Task['codelists:feminizidmap:add_citizenship_type'].execute
      Rake::Task['codelists:feminizidmap:add_citizenship'].execute
      Rake::Task['codelists:feminizidmap:add_legal_status'].execute
      Rake::Task['codelists:feminizidmap:add_location_type'].execute
      Rake::Task['codelists:feminizidmap:add_violent_actions'].execute
      Rake::Task['codelists:feminizidmap:add_weapons'].execute
      Rake::Task['codelists:feminizidmap:add_feminicide_type'].execute
      Rake::Task['codelists:feminizidmap:add_gender_identity'].execute
      Rake::Task['codelists:feminizidmap:add_relationship'].execute
      Rake::Task['codelists:feminizidmap:add_process_status'].execute
      Rake::Task['codelists:feminizidmap:add_sentence'].execute
      Rake::Task['codelists:feminizidmap:add_caller_in'].execute
      Rake::Task['codelists:feminizidmap:add_sources'].execute
    end

    desc 'Add media label'
    task add_media_label: :environment do
      list = Codelist.create(identifier: '1',
                             name: 'Mediale Bezeichbung',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Beziehungsdrama', description: '' },
                 { identifier: 2, name: 'Familiendrama', description: '' },
                 { identifier: 3, name: 'Mordlust', description: '' },
                 { identifier: 4, name: 'Tötung', description: '' },
                 { identifier: 5, name: 'Tötungsdelikt', description: '' },
                 { identifier: 6, name: 'Sonstiges', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add civil status'
    task add_civil_status: :environment do
      list = Codelist.create(identifier: '2',
                             name: 'Familienstand',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Beziehung (unverheiratet)', description: '' },
                 { identifier: 2, name: 'Eingetragene Partnerschaft', description: '' },
                 { identifier: 3, name: 'Geschieden', description: '' },
                 { identifier: 4, name: 'Getrennt', description: '' },
                 { identifier: 5, name: 'Single', description: '' },
                 { identifier: 6, name: 'Verheiratet', description: '' },
                 { identifier: 7, name: 'Verwitwet', description: '' },
                 { identifier: 8, name: 'Sonstiges', description: '' },
                 { identifier: 9, name: 'entfällt', description: '' },
                 { identifier: 10, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add educational background'
    task add_educational_background: :environment do
      list = Codelist.create(identifier: '3',
                             name: 'Bildungshintergrund',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Keine schulische Bildung', description: '' },
                 { identifier: 2, name: 'Grundschulbildung', description: '' },
                 { identifier: 3, name: 'Mittlere Reife (Haupt-/Realschulabschluss)', description: '' },
                 { identifier: 4, name: 'Abitur', description: '' },
                 { identifier: 5, name: 'Berufsschulabschluss', description: '' },
                 { identifier: 6, name: 'Ausbildung', description: '' },
                 { identifier: 7, name: 'Bachelor', description: '' },
                 { identifier: 8, name: 'Master', description: '' },
                 { identifier: 9, name: 'Doktor', description: '' },
                 { identifier: 10, name: 'Sonstiges', description: '' },
                 { identifier: 11, name: 'entfällt', description: '' },
                 { identifier: 12, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add citizenship'
    task add_citizenship_type: :environment do
      list = Codelist.create(identifier: '4',
                             name: 'Staatsbürgerschaft',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Deutsche Staatsbürgerschaft', description: '' },
                 { identifier: 2, name: 'Doppelte Staatsbürgerschaft (DE+andere)', description: '' },
                 { identifier: 3, name: 'Ausländische Staatsbürgerschaft', description: '' },
                 { identifier: 4, name: 'Doppelte Staatsbürgerschaft (beide ausländisch)', description: '' },
                 { identifier: 5, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add other cititzenship'
    task add_citizenship: :environment do
      list = Codelist.create(identifier: '5',
                             name: 'Ausländische Staatsbürgerschaft',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'entfällt', description: '' },
                 { identifier: 2, name: 'n/a', description: '' },
                 { identifier: 3, name: 'Land', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add legal status'
    task add_legal_status: :environment do
      list = Codelist.create(identifier: '6',
                             name: 'Rechtlicher Status',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Asylsuchend/geflüchtet', description: '' },
                 { identifier: 2, name: 'Aufenthaltsgenehmigung (ohne Geflüchtete)', description: '' },
                 { identifier: 3, name: 'Undokumentiert/ohne Papiere', description: '' },
                 { identifier: 4, name: 'entfällt', description: '' },
                 { identifier: 5, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add location'
    task add_location_type: :environment do
      list = Codelist.create(identifier: '7',
                             name: 'Fundort des Körpers',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Zuhause des Opfers', description: '' },
                 { identifier: 2, name: 'Zuhause des Täters', description: '' },
                 { identifier: 3, name: 'Gemeinsames Zuhause', description: '' },
                 { identifier: 4, name: 'Öffentlicher Raum', description: '' },
                 { identifier: 5, name: 'Arbeitsplatz', description: '' },
                 { identifier: 6, name: 'Privater Raum', description: '' },
                 { identifier: 7, name: 'Natur', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add violent action'
    task add_violent_actions: :environment do
      list = Codelist.create(identifier: '8',
                             name: 'Gewalthandlungen',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'In Flüssigkeit versenkt', description: '' },
                 { identifier: 2, name: 'Erdrosselt (mit Gegenstand)', description: '' },
                 { identifier: 3, name: 'Erhängt', description: '' },
                 { identifier: 4, name: 'Erschossen', description: '' },
                 { identifier: 5, name: 'Erstickt', description: '' },
                 { identifier: 6, name: 'Erstochen', description: '' },
                 { identifier: 7, name: 'Ertränkt', description: '' },
                 { identifier: 8, name: 'Gewürgt', description: '' },
                 { identifier: 9, name: 'Erwürgt (mit Händen)', description: '' },
                 { identifier: 10, name: 'In Stücke geschnitten', description: '' },
                 { identifier: 11, name: 'Kehle durchgeschnitten', description: '' },
                 { identifier: 12, name: 'Kopfschuss', description: '' },
                 { identifier: 13, name: 'Erschlagen', description: '' },
                 { identifier: 14, name: 'Schlag auf den Kopf', description: '' },
                 { identifier: 15, name: 'Zusammengeschlagen', description: '' },
                 { identifier: 16, name: 'Schnittwunden', description: '' },
                 { identifier: 17, name: 'Stichwunden', description: '' },
                 { identifier: 18, name: 'Schnittwunden', description: '' },
                 { identifier: 19, name: 'Verbrannt', description: '' },
                 { identifier: 20, name: 'Vergewaltigt', description: '' },
                 { identifier: 21, name: 'Vergewaltigt mit Gegenstand', description: '' },
                 { identifier: 22, name: 'Vergiftet', description: '' },
                 { identifier: 23, name: 'Vergraben', description: '' },
                 { identifier: 24, name: 'Verletzt', description: '' },
                 { identifier: 25, name: 'Brandverletzung', description: '' },
                 { identifier: 26, name: 'Verstümmelt', description: '' },
                 { identifier: 27, name: 'Gestoßen', description: '' },
                 { identifier: 28, name: 'Geschlagen', description: '' },
                 { identifier: 29, name: 'Überfahren', description: '' },
                 { identifier: 30, name: 'Gebissen', description: '' },
                 { identifier: 31, name: 'Gefesselt', description: '' },
                 { identifier: 32, name: 'Gewalteinwirkung', description: '' },
                 { identifier: 33, name: 'Nackt', description: '' },
                 { identifier: 34, name: 'In Koffer/Gegenstand gepackt', description: '' },
                 { identifier: 35, name: 'Gefoltert', description: '' },
                 { identifier: 36, name: 'Sonstiges', description: '' },
                 { identifier: 37, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add weapons'
    task add_weapons: :environment do
      list = Codelist.create(identifier: '9',
                             name: 'Waffen',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Hammer', description: '' },
                 { identifier: 2, name: 'Hände', description: '' },
                 { identifier: 3, name: 'Kopfkissen', description: '' },
                 { identifier: 4, name: 'Messer', description: '' },
                 { identifier: 5, name: 'Pharma-(Droge/Medikament)', description: '' },
                 { identifier: 6, name: 'Pistole', description: '' },
                 { identifier: 7, name: 'Plastiktüte', description: '' },
                 { identifier: 8, name: 'Säure', description: '' },
                 { identifier: 9, name: 'Seil', description: '' },
                 { identifier: 10, name: 'Stein', description: '' },
                 { identifier: 11, name: 'Werkzeuge', description: '' },
                 { identifier: 12, name: 'Axt/Hacke', description: '' },
                 { identifier: 13, name: 'Decke', description: '' },
                 { identifier: 14, name: 'Elektroimpulswaffe', description: '' },
                 { identifier: 15, name: 'Fahrzeug', description: '' },
                 { identifier: 16, name: 'Feuer', description: '' },
                 { identifier: 17, name: 'Gewehr', description: '' },
                 { identifier: 18, name: 'Gift', description: '' },
                 { identifier: 19, name: 'Schreckpistole', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add feminicide type'
    task add_feminicide_type: :environment do
      list = Codelist.create(identifier: '10',
                             name: 'Feminizidart',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Intim', description: '' },
                 { identifier: 2, name: 'Nicht intim', description: '' },
                 { identifier: 3, name: 'Prostitution', description: '' },
                 { identifier: 4, name: 'Menschenhandel / Sklav*innenhandel', description: '' },
                 { identifier: 5, name: 'Transphob', description: '' },
                 { identifier: 6, name: 'Lesbophob', description: '' },
                 { identifier: 7, name: 'Rassistisch', description: '' },
                 { identifier: 8, name: 'Genitalverstümmelung', description: '' },
                 { identifier: 9, name: 'Internationale Kriminalität / Genozid', description: '' },
                 { identifier: 10, name: 'Familiär ', description: '' },
                 { identifier: 11, name: 'Kindes-', description: '' },
                 { identifier: 12, name: 'als Beistehende', description: '' },
                 { identifier: 13, name: 'Sonstiges (bitte angeben)', description: '' },
                 { identifier: 14, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add gender identity'
    task add_gender_identity: :environment do
      list = Codelist.create(identifier: '11',
                             name: 'Geschlecht',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'männlich', description: '' },
                 { identifier: 2, name: 'weiblich', description: '' },
                 { identifier: 3, name: 'Sonstiges (bitte angeben)', description: '' },
                 { identifier: 4, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add relationship'
    task add_relationship: :environment do
      list = Codelist.create(identifier: '12',
                             name: 'Beziehung zum Opfer',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Vater', description: '' },
                 { identifier: 2, name: 'Onkel', description: '' },
                 { identifier: 3, name: 'Bruder / Brüder', description: '' },
                 { identifier: 4, name: 'Partner', description: '' },
                 { identifier: 5, name: 'Ex-Partner', description: '' },
                 { identifier: 6, name: 'Ehemann', description: '' },
                 { identifier: 7, name: 'Freund', description: '' },
                 { identifier: 8, name: 'Enkel', description: '' },
                 { identifier: 9, name: 'Großvater', description: '' },
                 { identifier: 10, name: 'Neffe', description: '' },
                 { identifier: 11, name: 'Sohn', description: '' },
                 { identifier: 12, name: 'Schwiegersohn', description: '' },
                 { identifier: 13, name: 'Stiefvater', description: '' },
                 { identifier: 14, name: 'Stiefbruder', description: '' },
                 { identifier: 15, name: 'Urenkel', description: '' },
                 { identifier: 16, name: 'Nachbar(n)', description: '' },
                 { identifier: 17, name: 'Bekannter', description: '' },
                 { identifier: 18, name: 'Vorgesetzter', description: '' },
                 { identifier: 19, name: 'Kollege', description: '' },
                 { identifier: 20, name: 'Kunde', description: '' },
                 { identifier: 21, name: 'Kein Beziehungsverhältnis', description: '' },
                 { identifier: 22, name: 'entfällt', description: '' },
                 { identifier: 23, name: 'Sonstiges', description: '' },
                 { identifier: 24, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add process status'
    task add_process_status: :environment do
      list = Codelist.create(identifier: '13',
                             name: 'Verfahrensstatus des Täters',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Auf Bewährung', description: '' },
                 { identifier: 2, name: 'Fall wegen Todes abgeschlossen', description: '' },
                 { identifier: 3, name: 'Flüchtig', description: '' },
                 { identifier: 4, name: 'Freigelassen', description: '' },
                 { identifier: 5, name: 'Freigelassen aufgrund von Krankheit', description: '' },
                 { identifier: 6, name: 'Freigesprochen', description: '' },
                 { identifier: 7, name: 'Jugendstrafanstalt', description: '' },
                 { identifier: 8, name: 'Nicht verfolgt', description: '' },
                 { identifier: 9, name: 'Unterbringung in psychiatrischer Klinik nach Gerichtsurteil', description: '' },
                 { identifier: 10, name: 'Unterbringung in psychiatrischer Klinik vor Gerichtsurteil', description: '' },
                 { identifier: 11, name: 'Untersuchungshaft', description: '' },
                 { identifier: 12, name: 'Verhaftet', description: '' },
                 { identifier: 13, name: 'Verurteilt', description: '' },
                 { identifier: 14, name: 'Vor Gericht, vorläufige Festnahme/Untersuchungshaft', description: '' },
                 { identifier: 15, name: 'Sonstiges', description: '' },
                 { identifier: 16, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add sentence'
    task add_sentence: :environment do
      list = Codelist.create(identifier: '14',
                             name: 'Straftsatz',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Mord', description: '' },
                 { identifier: 2, name: 'Totschlag', description: '' },
                 { identifier: 3, name: 'Minder schwerer Fall des Totschlags', description: '' },
                 { identifier: 4, name: 'Tötung auf Verlangen', description: '' },
                 { identifier: 5, name: 'Schwangerschaftsabbruch', description: '' },
                 { identifier: 6, name: 'Fahrlässige Tötung', description: '' },
                 { identifier: 7, name: 'Körperverletzung mit Todesfolge', description: '' },
                 { identifier: 8, name: 'Raub mit Todesfolge', description: '' }, { identifier: 1, name: 'männlich', description: '' },
                 { identifier: 9, name: 'Brandstiftung mit Todesfolge', description: '' },
                 { identifier: 10, name: 'Sexueller Übergriff, sexuelle Nötigung und Vergewaltigung mit Todesfolge', description: '' },
                 { identifier: 11, name: 'Erpresserischer Menschenraub bzw. Geiselnahme mit Todesfolge', description: '' },
                 { identifier: 12, name: 'Schuldunfähigkeit', description: '' },
                 { identifier: 13, name: 'Verminderte Schuldunfähigkeit', description: '' },
                 { identifier: 14, name: 'Auf Bewährung', description: '' },
                 { identifier: 15, name: 'Freispruch', description: '' },
                 { identifier: 16, name: 'entfällt', description: '' },
                 { identifier: 17, name: 'Sonstiges', description: '' },
                 { identifier: 18, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add types of caller in'
    task add_caller_in: :environment do
      list = Codelist.create(identifier: '15',
                             name: 'Benachrichtigung über die Tat',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Polizei', description: '' },
                 { identifier: 2, name: 'Täter', description: '' },
                 { identifier: 3, name: 'Rettungskräfte', description: '' },
                 { identifier: 4, name: 'Nachbar:innen', description: '' },
                 { identifier: 5, name: 'Zeug:innen', description: '' },
                 { identifier: 6, name: 'Bekannte', description: '' },
                 { identifier: 7, name: 'Anonyme:r Zeug:in', description: '' },
                 { identifier: 8, name: 'Opfer', description: '' }, { identifier: 1, name: 'männlich', description: '' },
                 { identifier: 9, name: 'Familienmitglied des Opfers', description: '' },
                 { identifier: 10, name: 'Pfleger:innen', description: '' },
                 { identifier: 11, name: 'Familienmitglied des Täters', description: '' },
                 { identifier: 12, name: 'Freund:in des Täters', description: '' },
                 { identifier: 13, name: 'Freund:in des Opfers', description: '' },
                 { identifier: 14, name: 'Mitbewohner:in', description: '' },
                 { identifier: 15, name: 'Partner:in des Opfers', description: '' },
                 { identifier: 16, name: 'Mitbewohner:in des Opfers', description: '' },
                 { identifier: 17, name: 'Mitbewohner:in des Täters', description: '' },
                 { identifier: 18, name: 'Partner:in des Täters', description: '' },
                 { identifier: 19, name: 'n/a', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add sources'
    task add_sources: :environment do
      list = Codelist.create(identifier: '16',
                             name: 'Quelle des Falls',
                             lang: 'de',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Medien', description: '' },
                 { identifier: 2, name: 'Rechtsfälle', description: '' },
                 { identifier: 3, name: 'Polizeiberichte', description: '' },
                 { identifier: 4, name: 'Zivilgesellschaftliche Berichte', description: '' },
                 { identifier: 5, name: 'Einzelpersonen', description: '' },
                 { identifier: 6, name: 'Sonstige', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end
  end
end
