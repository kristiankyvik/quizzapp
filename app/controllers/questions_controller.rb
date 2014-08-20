require 'pry'
class QuestionsController < ApplicationController
  def index
    @quiz = Quiz.find(params[:quiz_id])
    @user = User.find(params[:user_id])
    @question = Question.new
  end

  def create
    question = Quiz.find(params[:quiz_id]).questions.create(permitted_params)
    binding.pry
    question.save
    redirect_to :controller => :questions, :action => :index
  end

  private
  def permitted_params
    params.require(:question).permit(:title, :song, :explanation, :choice, choices_attributes: [:title, :correct])
  end
end
