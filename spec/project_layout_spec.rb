require 'spec_helper'

describe 'This project' do
  it 'uses RSpec instead of TestUnit' do
    Dir.exist?(File.join(File.dirname(__FILE__), '..', 'test')).should be_false
  end

  it 'uses the countries gem' do
    Country.new('US').should_not be_nil
  end
end