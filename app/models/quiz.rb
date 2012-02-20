class Quiz < ActiveRecord::Base
  HUMANIZED_ATTRIBUTES = {
    :min_age_years  => 'Minimum age in years',
    :country_alpha2 => 'Country'
  }

  validates :name, :owner_id, :min_age_years,
    :country_alpha2, :presence => true
  validates :min_age_years,
    :numericality => { :greater_than_or_equal_to => 0 }
  validates :country_alpha2,
    :inclusion => Country.all.map(&:last)
  attr_accessible :name, :video_id, :form_id, :min_age_years, :country_alpha2

  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
end