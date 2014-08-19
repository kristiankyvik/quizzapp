require 'pry'
class QuizzesController < ApplicationController
  def new
    @quiz = Quiz.new
    @user = User.find(params[:user_id])
  end

  def index
    @quiz = Quiz.new
    @user = User.find(params[:user_id])
  end

  def create
    user = User.find(params[:user_id])
    quiz = user.quizzes.create(permitted_params)
    quiz.save
    redirect_to :controller => 'questions', :action => 'index' ,:quiz_id => quiz.id
  end

  private
  def permitted_params
    params.require(:quiz).permit(:title)
  end
end
