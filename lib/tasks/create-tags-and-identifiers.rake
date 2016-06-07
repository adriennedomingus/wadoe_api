require 'csv'

tags = ['race ethnicity', 'exceptional student services', 'other', 'gender', 'all']

gender_identifiers = ['female', 'male']

race_ethnicity_identifiers = ['american indian or alaskan native',
                              'asian',
                              'asian pacific islander',
                              'black or african american',
                              'hispanic or latino',
                              'pacific islander',
                              'two or more races',
                              'white']

other_identifiers = ['foster care',
                     'free or reduced price lunch',
                     'homeless',
                     'transitional bilingual',
                     'title i migrant']

ess_identifiers = ['section 504',
                   'special education']

namespace :db do
  task create_tags_and_identifiers: :environment do
    tags.each do |tag|
      Tag.find_or_create_by(name: tag)
    end

    gender_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'gender')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    race_ethnicity_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'race ethnicity')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    other_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'other')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    ess_identifiers.each do |identifier|
      tag = Tag.find_by(name: 'exceptional student services')
      StudentIdentifier.find_or_create_by(name: identifier, tag_id: tag.id)
    end

    all_tag = Tag.find_by(name: 'all')
    StudentIdentifier.find_or_create_by(name: 'all', tag_id: all_tag.id)
  end
end
