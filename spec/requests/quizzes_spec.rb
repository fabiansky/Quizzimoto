require 'spec_helper'

describe "Quizzes" do
  %w(/ /quizzes).each do |path|
    it 'should redirect you to login' do
      visit path
      page.current_url.should == 'http://www.example.com/oauth2authorize'
    end
  end

  it 'shows a list of quizzes' do
    login
    Factory :quiz
    visit '/'
    page.should have_content('Scrabble for Nihilists')
    page.should have_content('47')
    page.should have_content('United States')
  end

  it 'says something when there are no quizzes' do
    login
    page.should have_content('There are no quizzes yet')
  end

  it 'allows you to create a new quiz' do
    login
    visit '/'
    click_link 'Create a new quiz'
    page.should have_content('New quiz')
  end
end
