require_relative 'session_helpers.rb'
require 'rails_helper'
require 'spec_helper'


feature 'play quiz' do
  before (:all) do
    create_test_quiz
    visit '/'
    click_link 'Login'
    sign_in_with 'test@test.com', 'testpassword'
    visit '/users/1/quizzes/1'
  end

  scenario 'should redirect to right page' do
    page.has_content?('Play Quiz')
  end


end
