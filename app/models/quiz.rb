class Quiz < ActiveRecord::Base
  validates :name, :playlist_id, :min_age_years, :country_alpha2,
    :presence => true
  validates :min_age_years,
    :numericality => { :greater_than_or_equal_to => 0 }
  validates :country_alpha2,
    :inclusion => Country.all.map(&:last)
end