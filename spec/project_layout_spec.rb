require 'spec_helper'

describe 'This project' do
  it 'uses RSpec instead of TestUnit' do
    Dir.exist?(File.join(File.dirname(__FILE__), '..', 'test')).should be_false
    Dir.exist?(File.join(File.dirname(__FILE__), '..', 'spec')).should be_true
  end

  it 'prefers request specs with Capybara over view specs' do
     Dir.exist?(File.join(File.dirname(__FILE__), 'views')).should be_false
     Dir.exist?(File.join(File.dirname(__FILE__), 'requests')).should be_true
   end

  it 'uses the countries gem' do
    Country.new('US').should_not be_nil
  end
end