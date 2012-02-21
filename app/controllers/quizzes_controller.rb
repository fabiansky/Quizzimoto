class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all
  end

  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new

    # Set a default.
    @quiz.country_alpha2 = 'US'
  end

  def edit
    @quiz = Quiz.find(params[:id])
    unless @quiz.video_id.blank?
      response = fetch_youtube_resource(
        :uri => 'https://gdata.youtube.com/feeds/api/videos/' +
                CGI::escape(@quiz.video_id) +
                '?v=2&alt=jsonc')
      if response.status != 200
        logger.warn("Couldn't load video: #{response.body}")
        @video_entry = nil
      else
        @video_entry = JSON.parse(response.body)
      end
    end
  end

  def create
    @quiz = Quiz.new(params[:quiz])
    @quiz.owner_id = current_user_id

    if @quiz.save
      redirect_to(edit_quiz_url(@quiz), :notice => 'Quiz was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz.update_attributes(params[:quiz])
      if params[:keep_editing] == 'true'
        url = edit_quiz_url(@quiz)
      else
        url = @quiz
      end
      redirect_to(url, :notice => 'Quiz was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    redirect_to(quizzes_url)
  end

  def video_search
    @quiz = Quiz.find(params[:quiz_id])
    unless params[:q].blank?
      response = fetch_youtube_resource(
        :uri => 'https://gdata.youtube.com/feeds/api/videos?v=2&alt=jsonc&q=' +
                CGI::escape(params[:q]))
      @search_results = JSON.parse(response.body)
    end
  end
end
