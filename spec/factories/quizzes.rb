# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    name "MyString"
    playlist_id "MyString"
    min_age_years 1
    country_alpha2 "MyString"
  end
end
