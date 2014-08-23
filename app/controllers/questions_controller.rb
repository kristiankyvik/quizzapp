require 'pry'
class QuestionsController < ApplicationController
  def index
    @quiz = Quiz.find(params[:quiz_id])
    @user = User.find(params[:user_id])
    @question = Question.new
    @questions = @quiz.questions
  end

  def create
    question = Quiz.find(params[:quiz_id]).questions.create(permitted_params)
    question.save
    redirect_to :controller => :questions, :action => :index
  end

  def edit
    @user = User.find(params[:user_id])
    @quiz = Quiz.find(params[:quiz_id])
    @question = Question.find(params[:id])
    render 'edit'
  end

  def update
    quiz = Quiz.find(params[:quiz_id])
    quiz.questions.destroy(params[:id])
    if quiz.questions.create(permitted_params)
      redirect_to :controller => :questions, :action => :index
    else
      @user = User.find(params[:user_id])
      @quiz = Quiz.find(params[:quiz_id])
      @question = Question.find(params[:id])
      render 'edit'
    end 
  end

  def destroy
    Question.destroy(params[:id])
    redirect_to( action: 'index', controller: 'questions')
  end




  private
  def permitted_params
    params.require(:question).permit(:title, :image_url, :song, :explanation, :choice, choices_attributes: [:title, :correct])
  end
end
