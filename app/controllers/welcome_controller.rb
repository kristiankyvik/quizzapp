class WelcomeController < ApplicationController
  def home
    @quizzes = Quiz.all
  end
end
