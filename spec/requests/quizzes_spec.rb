require 'spec_helper'

describe "Quizzes" do
  before(:each) do
    stub_plus_discovery_document
    stub_current_user_profile
  end

  %w(/ /quizzes).each do |path|
    it 'should redirect you to login' do
      visit path
      page.current_url.should == 'http://www.example.com/oauth2authorize'
    end
  end

  describe 'index' do
    it 'shows a list of quizzes' do
      Factory :quiz
      login
      page.should have_content('Scrabble for Nihilists')
      page.should have_content('47')
      page.should have_content('United States')
    end

    it 'says something when there are no quizzes' do
      login
      page.should have_content('There are no quizzes yet')
    end

    it 'has a link to create a new quiz' do
      login
      click_link 'Create a new quiz'
    end
  end

  describe 'new' do
    it 'uses a human friendly field names' do
      login
      click_link 'Create a new quiz'
      page.should have_content('Country')
      page.should_not have_content('Country alpha2')
      page.should have_content('Minimum age')
      page.should_not have_content('Min age years')
    end

    it 'is a simple page that leads to a more complicated edit page' do
      login
      click_link 'Create a new quiz'

      # I should see a Name field but not a Video or Form field.
      find '#quiz_name'
      lambda { find '#quiz_video_id' }.should raise_error(Capybara::ElementNotFound)
      lambda { find '#quiz_form_id'  }.should raise_error(Capybara::ElementNotFound)

      fill_in 'Name', :with => 'JJ'
      fill_in 'Minimum age', :with => 36
      click_button 'Create Quiz'
      
      page.should have_content('Quiz was successfully created.')
      page.should have_content('Editing quiz')
      find '#quiz_name'
      find '#quiz_video_id'
      find '#quiz_form_id'
    end
  end

  describe 'edit' do
    # Advanced validation is tested in models/quiz_spec.rb.
    it 'does validation' do
      login
      visit new_quiz_path
      click_button 'Create Quiz'
      page.should have_content("Name can't be blank")
    end

    it 'has a country_select' do
      quiz = Factory :quiz
      login
      visit edit_quiz_url(quiz)
      select 'Portugal', :from => 'Country'
      click_button 'Update'
      page.should have_content('Portugal')
    end

    it 'has a field to edit the form_id' do
      quiz = Factory :quiz
      login
      visit edit_quiz_url(quiz)
      fill_in 'Form', :with => 'new_form_id'
      click_button 'Update'
      quiz.reload
      quiz.form_id.should == 'new_form_id'
    end

    it 'lets you search for and select a YouTube video' do
      filename = Rails.root.join(
        'spec/support/documents/gdata.youtube.com/feeds/api/videos?v=2&alt=jsonc&q=Pythagorean+Theorem+in+60+Seconds')
      stub_request(:get, 'https://gdata.youtube.com/feeds/api/videos?alt=jsonc&q=Pythagorean%20Theorem%20in%2060%20Seconds&v=2').
        with(:headers => 
          {'Authorization' => 'Bearer 12345', 
           'X-Gdata-Key'   => 'key=AI39si7sYNfF3-xVbZUalnyU-0CjvnwucP0u4edZ_uCm02GaM8RajpeTBJ3LWprdw_THhdvDNwjy2UPO4dCH3a0LG8B25cQnkQ'}).
        to_return(:status => 200, :body => IO.read(filename))

      quiz = Factory :quiz, :video_id => nil
      login
      visit edit_quiz_url(quiz)
      page.should have_content('This is no video associated with this quiz yet.')

      click_link 'Search for a video'
      fill_in 'q', :with => 'Pythagorean Theorem in 60 Seconds'
      click_button 'Search'
      page.should have_content('Pythagorean Theorem in 60 Seconds')

      click_button 'Use This Video'
      quiz.reload
      quiz.video_id.should == '0HYHG3fuzvk'
      page.should have_content('Editing quiz')
      page.should have_content('Pythagorean Theorem in 60 Seconds')
      page.should_not have_content('This is no video associated with this quiz yet.')
    end
  end

  describe 'show' do
    it 'has an edit link' do
      Factory :quiz
      login
      click_link 'Scrabble for Nihilists'
      click_link 'Edit'
    end

    it 'shows an embedded player' do
      Factory :quiz
      login
      click_link 'Scrabble for Nihilists'
      page.should have_css('iframe.player')
    end

    it 'shows an embedded form' do
      Factory :quiz
      login
      click_link 'Scrabble for Nihilists'
      page.should have_css('iframe.form')      
    end

    it 'tells you if there is no video' do
      Factory :quiz, :video_id => nil
      login
      click_link 'Scrabble for Nihilists'
      page.should have_content('This is no video associated with this quiz yet.')
    end

    it 'tells if you if there is no form' do
      Factory :quiz, :form_id => nil
      login
      click_link 'Scrabble for Nihilists'
      page.should have_content('This is no form associated with this quiz yet.')
    end
  end
end