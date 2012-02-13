class WelcomeController < ApplicationController
  def index
    @quizzes = Quiz.all
  end
end
