class GamesController < ApplicationController

  def index
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
    render 'play'
  end

  def server
    @user_id =params[:user_id]
    @quiz_id =params[:quiz_id]
  end

  def refresh
    session[:players] = ["nicjasds", "sdsdsds"]
    session[:scores] = {}
    session[:answersheet] = []
    render :nothing => true
  end
  
  def start
    Pusher['test_channel'].trigger('start_game', {
      message: "start quiz"
    })
    render :nothing => true
  end

  def client
  end

  def next_question
    Pusher['test_channel'].trigger('next_question', {
    })
    render :nothing => true
  end

  def answersheet
    session[:answersheet] = params[:sheet]
    Pusher['server_channel'].trigger('got_answer_sheet', {
      sheet: session[:answersheet].map { |i| "'" + i.to_s + "'" }.join(","),
      players: session[:players].map { |i| "'" + i.to_s + "'" }.join(","),
      scores: session[:scores].map { |i| "'" + i.to_s + "'" }.join(",")
    })

    render :nothing => true
  end

  def answer
    username = params[:username]
    question = params[:question]
    answer = params[:answer]
    session[:scores][username] ||= 0

    if (session[:answersheet][question.to_i] == answer)
      session[:scores][username] += 1
    end

    Pusher['server_channel'].trigger('update_score', {
      message:  session[:scores],
      answer: answer,
      answersheet: session[:answersheet].map { |i| "'" + i.to_s + "'" }.join(","),
      correct: session[:answersheet][question.to_i]
    })
    render :nothing => true
  end

  def signup
    player_name = params[:username]
    session[:players] << player_name
    Pusher['server_channel'].trigger('new_signup', {
      message:  session[:players].map { |i| "'" + i.to_s + "'" }.join(",")
    })

    respond_to do |format|
          format.json {
            render json: { :message => "message"}
        }
    end
  end

end
