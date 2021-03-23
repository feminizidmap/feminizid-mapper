# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

codelists = [{ identifier: 1, name: 'Gender identity', lang: 'en', description: '' },
             { identifier: 2, name: 'Sexual orientation', lang: 'en', description: '' },
             { identifier: 3, name: 'Educational level', lang: 'en', description: '' },
             { identifier: 1, name: 'Genderidentität', lang: 'de', description: '' },
             { identifier: 2, name: 'Sexuelle Orientierung', lang: 'de', description: '' },
             { identifier: 3, name: 'Bildungsgrad', lang: 'de', description: '' }]

codelists.each do |v, _i|
  Codelist.create(identifier: v[:identifier],
                  name: v[:name],
                  lang: v[:lang],
                  description: v[:description])
end
