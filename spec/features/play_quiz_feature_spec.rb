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

  scenario 'should create layout' do
    page.has_content?('ola')
    page.has_content?('Play Quiz')
    page.has_content?('quiz test title')
    page.has_content?('PLAY')

  end
  scenario 'should create layout', js: true do
    visit '/'
    find('#fuck').click
    page.has_content?('la ostia')
  end

end
