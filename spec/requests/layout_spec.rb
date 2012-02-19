require 'spec_helper'

describe 'Layout' do
  before(:each) do
    stub_plus_discovery_document
    stub_current_user_profile
  end

  describe 'After logging in' do
    it 'Show stuff specific to the current user' do
      login
      page.should have_content('Shannon Behrens')
      page.should have_css('img.profile_pic')
    end
  end
end