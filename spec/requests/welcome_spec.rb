require 'spec_helper'

describe 'Welcome' do
  %w(/ /welcome/index).each do |path|
    it 'should redirect you to login' do
      visit path
      page.current_url.should == 'http://www.example.com/oauth2authorize'
    end
  end

  it "shows a list of quizzes" do
    Factory :quiz
    visit '/'
    page.should have_content('Factoring Primes')
    page.should have_content('13')
    page.should have_content('United States')
  end
end