require 'spec_helper'

describe Quiz do
  # Basic validation is tested in requests/quizzes_spec.rb.

  [['a', false],
   [-1, false],
   [0, true],
   [1, true]].each do |test|
    input, expected = test

    it "requires min_age_years to be a number >= 0 (#{input}, #{expected})" do
      quiz = Factory :quiz
      quiz.min_age_years = input
      quiz.valid?.should == expected
    end
  end
  
  [['United States', false],
   ['USA', false],
   ['__', false],
   ['US', true]].each do |test|
    input, expected = test

    it "requires country_alpha2 to be a valid 2 letter country code (#{input}, #{expected})" do
      quiz = Factory :quiz
      quiz.country_alpha2 = input
      quiz.valid?.should == expected
    end
  end

  it 'has an owner_id' do
    quiz = Factory :quiz
    quiz.owner_id.should_not be_nil
  end

  it 'has a video_id' do
    quiz = Factory :quiz
    quiz.video_id.should_not be_nil
  end

  it 'should not allow mass assignment to owner_id' do
    quiz = Factory :quiz
    quiz.update_attributes!(:owner_id => 'new owner_id')
    quiz.owner_id.should == 'owner_id'
  end
end