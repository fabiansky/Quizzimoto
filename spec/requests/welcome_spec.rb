require 'spec_helper'

describe 'Welcome' do
  %w(/ /welcome/index).each do |path|
    it 'should redirect you to login' do
      visit path
      page.current_url.should == 'http://www.example.com/oauth2authorize'
    end
  end
end