require 'rails_helper'
require 'pry'

RSpec.describe Question, :type => :model do
  # before(:each) do
  #   @question = FactoryGirl.build(:question)
  # end

  # context "when question has minimum 2 answers" do
  #   it "question is not valid with two true answers" do
  #     @question.choices.new(title: "a1", correct: true)
  #     @question.choices.new(title: "a2", correct: true)
  #     expect(@question).not_to be_valid
  #   end

  #   it "question is not valid with two false answers" do
  #     @question.choices.new(title: "a1", correct: false)
  #     @question.choices.new(title: "a2", correct: false)
  #     expect(@question).not_to be_valid
  #   end

  #   it "question is valid with one true and one false answer" do
  #     @question.choices.new(title: "a1", correct: false)
  #     @question.choices.new(title: "a2", correct: true)
  #     expect(@question).to be_valid
  #   end
  # end

  # context "when question has enough choices" do
  #   before (:each) do
  #     @question
  #     @question.choices.new(title: "a1", correct: false)
  #     @question.choices.new(title: "a2", correct: true)
  #   end

  #   it "needs to be attached to a quiz to be valid" do
  #     @question.quiz_id=nil
  #     expect(@question).not_to be_valid
  #   end

  #   it "can have maximum gour answers" do
  #     @question.choices.new(title: "a3", correct: false)
  #     @question.choices.new(title: "a4", correct: false)
  #     @question.choices.new(title: "a5", correct: false)
  #     expect(@question).not_to be_valid
  #   end

  # end
    
end