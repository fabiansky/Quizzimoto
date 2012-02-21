class ThumbnailsController < ApplicationController
  def thumbnails
    @quizzes = Quiz.all
  end
end
