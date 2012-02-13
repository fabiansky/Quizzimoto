require 'spec_helper'

describe "quizzes/index" do
  before(:each) do
    assign(:quizzes, [
      stub_model(Quiz,
        :name => "Name",
        :playlist_id => "Playlist",
        :min_age_years => 1,
        :country_alpha2 => "Country Alpha2"
      ),
      stub_model(Quiz,
        :name => "Name",
        :playlist_id => "Playlist",
        :min_age_years => 1,
        :country_alpha2 => "Country Alpha2"
      )
    ])
  end

  it "renders a list of quizzes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Playlist".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country Alpha2".to_s, :count => 2
  end
end
