require 'spec_helper'

describe "Quizzes" do
  describe "GET /quizzes" do
    it "doesn't crash" do
      login
      visit quizzes_path
      page.should have_content('Listing quizzes')
    end
  end
end
