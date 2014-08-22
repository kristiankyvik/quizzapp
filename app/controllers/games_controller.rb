class GamesController < ApplicationController
  def index
    Pusher['test_channel'].trigger('my_event', {
      message: 'hello world'
    })
    render 'play'
  end

  def server
    session[:players] = []
  end

  def start
    Pusher['test_channel'].trigger('start_game', {
      message: "start quiz"
    })
    render :nothing => true
  end

  def client
   
  end

  def signup
    username = params[:username]
    session[:players] ||= []
    session[:players] << params[:username]
    # session["#{username}"] = params[:username]
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
