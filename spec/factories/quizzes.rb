# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    name 'Scrabble for Nihilists'
    owner_id 'owner_id'
    video_id '4RjsedD_Qjc'
    form_id 'dEI4TWtYaklKX0NTRnFBTC1SRWRscWc6MQ'
    min_age_years '47'
    country_alpha2 'US'
  end
end
