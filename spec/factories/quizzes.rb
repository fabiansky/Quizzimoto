# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    name 'Scrabble for Nihilists'
    owner_id 'owner_id'
    playlist_id 'playlist_id'
    min_age_years '47'
    country_alpha2 'US'
  end
end
