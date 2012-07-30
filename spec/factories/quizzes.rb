# Copyright 2012 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :quiz do
    name 'Scrabble for Nihilists'
    owner_id 'owner_id'
    min_age_years '47'
    country_alpha2 'US'
  end

  factory :complete_quiz, :class => Quiz do
    name 'Trigonometry'
    owner_id 'owner_id'
    video_id '0HYHG3fuzvk'
    form_id 'dEI4TWtYaklKX0NTRnFBTC1SRWRscWc6MQ'
    min_age_years '14'
    country_alpha2 'US'
  end
end
