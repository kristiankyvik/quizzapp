class GamesController < ApplicationController


  def index

  end

  def server
    Game.destroy(100)

    @user_id =params[:user_id]
    @quiz_id =params[:quiz_id]
    @game = Game.create(id: 100, cheatsheet: [])
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
    sheet = params[:sheet]
    game = Game.find(100)
    game.cheatsheet = sheet
    game.save


    render :nothing => true
  end

  def answer
    username = params[:username]
    question = params[:question]
    answer = params[:answer]
    game = Game.find(100)
    player = game.players.find_by(username: username)
    puts "#"*40
    puts game.cheatsheet[question.to_i]
    puts answer
    if (game.cheatsheet[question.to_i] == answer.to_i)
      player.score += 1
      player.save!
    end

    Pusher['server_channel'].trigger('update_score', {
      username: username,
      answer: answer,
      score: player.score 
    })
    render :nothing => true
  end

  def signup
    username = params[:username]
    game = Game.find(100)
    game.players.create(username: username)
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
