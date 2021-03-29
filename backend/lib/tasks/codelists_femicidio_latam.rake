# frozen_string_literal: true

namespace :codelists do
  namespace :femicidios_latam do
    desc 'Import default codelists as documented in femicidios-latam'
    task add_default: :environment do
      Rake::Task['codelists:femicidios_latam:add_sexual_orientation'].execute
      Rake::Task['codelists:femicidios_latam:add_gender_identity'].execute
      Rake::Task['codelists:femicidios_latam:add_victim_type'].execute
      Rake::Task['codelists:femicidios_latam:add_relationship_type'].execute
      Rake::Task['codelists:femicidios_latam:add_location_type'].execute
      Rake::Task['codelists:femicidios_latam:add_judical_situation'].execute
      Rake::Task['codelists:femicidios_latam:add_educational_level'].execute
      Rake::Task['codelists:femicidios_latam:add_modality'].execute
    end

    desc 'Add modality'
    task add_modality: :environment do
      list = Codelist.create(identifier: '8',
                             name: 'Modalidad',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Golpes', description: 'Muerte por golpes.' },
                 { identifier: 2, name: 'Disparo de bala', description: 'Muerte por disparo de bala.' },
                 { identifier: 3, name: 'Apuñalamiento', description: 'Muerte por apuñalamiento.' },
                 { identifier: 4, name: 'Quemaduras', description: 'Muerte por quemaduras.' },
                 { identifier: 5, name: 'Asfixia', description: 'Muerte por asfixia.' },
                 { identifier: 6, name: 'Ahogamiento', description: 'Muerte por ahogamiento.' },
                 { identifier: 7, name: 'Ataladramiento', description: 'Ataladramiento.' },
                 { identifier: 8, name: 'Atropellamiento', description: 'Asesinada por Atropellamiento.' },
                 { identifier: 9, name: 'Estrangulamiento', description: 'Asesinada por estrangulamiento.' },
                 { identifier: 10, name: 'Otros medios', description: 'Asesinada por otros medios.' },
                 { identifier: 11, name: 'Se desconoce', description: 'Se desconoce la modalidad.' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add educational level'
    task add_educational_level: :environment do
      list = Codelist.create(identifier: '7',
                             name: 'Nivel Educativo',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Educación de la primera infancia', description: '' },
                 { identifier: 2, name: 'Menos que primaria', description: '' },
                 { identifier: 3, name: 'Educación primaria', description: '' },
                 { identifier: 4, name: 'Educación secundaria baja', description: '' },
                 { identifier: 5, name: 'Educación secundaria alta', description: '' },
                 { identifier: 6, name: 'Educación postsecundaria no terciaria', description: '' },
                 { identifier: 7, name: 'Educación terciaria de ciclo corto', description: '' },
                 { identifier: 8, name: 'Grado en educación terciaria o nivel equivalente', description: '' },
                 { identifier: 9, name: 'Nivel de maestría, especialización o equivalente', description: '' },
                 { identifier: 10, name: 'Nivel de doctorado o equivalente', description: '' },
                 { identifier: 11, name: 'Se desconoce', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add judical situation'
    task add_judical_situation: :environment do
      list = Codelist.create(identifier: '6',
                             name: 'Situacion juridica',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Imputado', description: '' },
                 { identifier: 2, name: 'Indagado', description: '' },
                 { identifier: 3, name: 'Procesado', description: '' },
                 { identifier: 4, name: 'Acusado', description: '' },
                 { identifier: 5, name: 'Condenado', description: '' },
                 { identifier: 6, name: 'Fugitivo', description: '' },
                 { identifier: 7, name: 'En Libertad Condicional', description: '' },
                 { identifier: 8, name: 'Presion Preventiva', description: '' },
                 { identifier: 9, name: 'Otro', description: '' },
                 { identifier: 10, name: 'Se desconoce', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add location type'
    task add_location_type: :environment do
      list = Codelist.create(identifier: '5',
                             name: 'Tipo lugar',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Domicilio victima', description: '' },
                 { identifier: 2, name: 'Domicilio imputado', description: '' },
                 { identifier: 3, name: 'Domicilio particular', description: '' },
                 { identifier: 4, name: 'Espacio Abierto, Calle o transporte público.', description: '' },
                 { identifier: 5, name: 'Puesto de Trabajo', description: '' },
                 { identifier: 6, name: 'Institución educativa, Escuelas u otras instituciones educativas',
                   description: '' },
                 { identifier: 7, name: 'Prisión, Instituciones penales o correcionales', description: '' },
                 { identifier: 8, name: 'Institucion,Entornos de atención institucional',
                   description: '(incluyen: hospitales, instalaciones psiquiátricas, hogares de atención residencial o jubilación, casas de detención preventiva y otras instalaciones de atención institucional)' },
                 { identifier: 9, name: 'Otro', description: '' },
                 { identifier: 10, name: 'Se desconoce', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add relationship type'
    task add_relationship_type: :environment do
      list = Codelist.create(identifier: '4',
                             name: 'Tipo relation',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Padre', description: 'Imputado es padre de la víctima.' },
                 { identifier: 2, name: 'Madre', description: 'Imputado es madre de la víctima.' },
                 { identifier: 3, name: 'Padrastro', description: 'Imputado es padrastro de la víctima.' },
                 { identifier: 4, name: 'Madrastra', description: 'Imputado es madrastra de la víctima.' },
                 { identifier: 5, name: 'Tutor/a', description: 'Imputado es tutor/a de la víctima.' },
                 { identifier: 6, name: 'Esposo/a', description: 'Imputado es esposo/a de la víctima.' },
                 { identifier: 7, name: 'Concubino/a', description: 'Imputado es concubino/a de la víctima.' },
                 { identifier: 8, name: 'Novio/a', description: 'Imputado es novio/a de la víctima.' },
                 { identifier: 9, name: 'Amante', description: 'Imputado es amante de la víctima.' },
                 { identifier: 10, name: 'Pareja anterior', description: ' Pareja o cónyuge anterior.' },
                 { identifier: 11, name: 'Pariente', description: 'Imputado es pariente consanguíneo de la víctima.' },
                 { identifier: 12, name: 'Laboral', description: 'Imputado es empleado/a o colega de la víctima.' },
                 { identifier: 13, name: 'Conocido/a', description: 'Imputado es conocido/a de la víctima.' },
                 { identifier: 14, name: 'Amigo', description: 'Amigo de la víctima.' },
                 { identifier: 15, name: 'Otro Transgresor', description: 'Otro transgresor conocido por la víctima.' },
                 { identifier: 16, name: 'Autoridad', description: 'Por autoridades oficiales' },
                 { identifier: 17, name: 'Desconocido/a', description: 'Imputado no es conocido/a la víctima.' },
                 { identifier: 18, name: 'Se desconoce', description: 'Se desconoce el tipo de relación.' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add type of victim'
    task add_victim_type: :environment do
      list = Codelist.create(identifier: '3',
                             name: 'Tipo victima',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Principal', description: 'La victima principal del feminicidio.' },
                 { identifier: 2, name: 'Vinculado', description: 'Victima vinculada al crimén principal.' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add sexual orientation options'
    task add_sexual_orientation: :environment do
      list = Codelist.create(identifier: '2',
                             name: 'Orientacion sexual',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Lesbiana', description: '' },
                 { identifier: 2, name: 'Gay', description: '' },
                 { identifier: 3, name: 'Heterosexual', description: '' },
                 { identifier: 4, name: 'Bisexual', description: '' },
                 { identifier: 5, name: 'Asexual', description: '' },
                 { identifier: 6, name: 'Otro', description: '' },
                 { identifier: 7, name: 'Se desconoce', description: '' }]

      options.each do |o|
        CodelistItem.new(identifier: o[:identifier],
                         name: o[:name],
                         description: o[:description],
                         codelist: list,
                         lang: list.lang).save
      end
    end

    desc 'Add gender identity options'
    task add_gender_identity: :environment do
      list = Codelist.create(identifier: '1',
                             name: 'Identidad genero',
                             lang: 'es',
                             description: '')
      list.save

      options = [{ identifier: 1, name: 'Cis Hombre', description: 'Hombre identificado con el genero que se le asigno al nacer.' },
                 { identifier: 2, name: 'Cis Mujer',
                   description: 'Mujer identificada con el genero que se le asigno al nacer.' },
                 { identifier: 3, name: 'No Binario',
                   description: 'Persona no identificada con genero masculino o femenino.' },
                 { identifier: 4, name: 'Otro', description: 'Otra identidad de genero.' },
                 { identifier: 5, name: 'Se Desconoce', description: 'Se desconoce el genero.' },
                 { identifier: 6, name: 'Mujer Trans',
                   description: 'Mujer que no se identifica con el genero asignado al nacer.' },
                 { identifier: 7, name: 'Hombre Trans',
                   description: 'Hombre que no se identifica con el genero asignado al nacer.' }]

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
