require 'spec_helper'

describe 'OAuth2' do
  it 'forces you to login' do
    visit '/'
    page.current_url.should == 'http://www.example.com/oauth2authorize'
    page.should have_content('This application lets you build video-based quizzes')
    page.should have_content('Login to continue')
  end

  it 'lets you view the welcome page if you login' do
    login
    page.current_url.should == 'http://www.example.com/'
    page.should have_content('This application lets you build video-based quizzes')
    page.should_not have_content('Login to continue')
  end

  context '/oauth2callback' do
    it 'crashes unless you pass a code parameter' do
      lambda { visit '/oauth2callback' }.should raise_exception(ArgumentError)
    end
  end
end