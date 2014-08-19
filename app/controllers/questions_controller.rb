class QuestionsController < ApplicationController



  def index
    @quiz = Quiz.find(params[:quiz_id])
    @user = User.find(params[:user_id])
    @question = Question.new
  end

  def create
    question = Quiz.find(params[:quiz_id]).questions.create(question_params)
    question.save
    redirect_to :controller => :questions, :action => :index
  end

  private
  def question_params
    params.require(:question).permit(:title, choices_attributes: [:title, :correct])
  end
end
