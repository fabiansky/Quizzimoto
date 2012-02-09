require 'spec_helper'

describe 'OAuth2' do
  it 'forces you to login' do
    visit '/'
    page.current_url.should == 'http://www.example.com/oauth2authorize'
    page.should have_content('This application lets you build video-based quizzes')
    page.should have_content('Login to continue')
  end
end