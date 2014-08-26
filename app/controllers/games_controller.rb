class GamesController < ApplicationController
  @@scores = {}

  def index
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
    render 'play'
  end

  def server
    session[:players] = []
    session[:scores] = {}
    session[:answersheet] = []
    @user_id =params[:user_id]
    @quiz_id =params[:quiz_id]
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
      message:  session[:scores]
    })
    render :nothing => true
  end

  def signup
    username = params[:username]
    session[:players] ||= []
    session[:players] << params[:username]
    Pusher['server_channel'].trigger('new_signup', {
      message: username
    })

    respond_to do |format|
          format.json {
            render json: { :message => "message"}
        }
    end
  end

end
