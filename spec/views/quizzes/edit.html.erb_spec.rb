require 'spec_helper'

describe "quizzes/edit" do
  before(:each) do
    @quiz = assign(:quiz, stub_model(Quiz,
      :name => "MyString",
      :playlist_id => "MyString",
      :min_age_years => 1,
      :country_alpha2 => "MyString"
    ))
  end

  it "renders the edit quiz form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => quizzes_path(@quiz), :method => "post" do
      assert_select "input#quiz_name", :name => "quiz[name]"
      assert_select "input#quiz_playlist_id", :name => "quiz[playlist_id]"
      assert_select "input#quiz_min_age_years", :name => "quiz[min_age_years]"
      assert_select "input#quiz_country_alpha2", :name => "quiz[country_alpha2]"
    end
  end
end
