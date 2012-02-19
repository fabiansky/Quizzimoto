require 'spec_helper'

describe 'Layout' do
  before(:each) do
    stub_plus_discovery_document
    stub_current_user_profile
  end
  
  it 'has a link to the homepage' do
    login
    click_link 'Quizzimoto'
    page.current_url.should == 'http://www.example.com/'
  end

  it 'shows stuff specific to the current user' do
    login
    page.should have_content('Shannon Behrens')
    page.should have_css('#profile_pic img')
  end
end