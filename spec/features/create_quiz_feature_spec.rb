require_relative 'session_helpers.rb'
require 'rails_helper'

feature 'Create a quiz' do
  before (:each) do
    visit '/'
    click_link 'Sign in'
    sign_in_with 'valid@example.com', 'password12345'
  end

  scenario 'goes to profile page' do
    click_link 'profile'
    expect(page).to have_content('profile')
  end


  scenario 'goes user/:id/quizzes/new page' do
    click_button 'new quiz'
    expect(page).to have_content('song')
  end

  scenario 'fills in form' do
    fill_in 'Title', with: 'the rap test'
    expect(page).to have_content('add question')
  end
end