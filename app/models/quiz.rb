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

class Quiz < ActiveRecord::Base
  HUMANIZED_ATTRIBUTES = {
    :min_age_years  => 'Minimum age',
    :country_alpha2 => 'Country'
  }

  validates :name, :owner_id, :min_age_years,
    :country_alpha2, :presence => true
  validates :min_age_years,
    :numericality => { :greater_than_or_equal_to => 1 }
  validates :country_alpha2,
    :inclusion => Country.all.map(&:last)
  attr_accessible :name, :video_id, :form_id, :min_age_years, :country_alpha2

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end