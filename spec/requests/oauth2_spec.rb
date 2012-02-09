require 'spec_helper'

describe 'OAuth2' do
  it 'forces you to login before you can see the welcome page' do
    visit '/'
    page.should have_content('Login to continue')
  end
end