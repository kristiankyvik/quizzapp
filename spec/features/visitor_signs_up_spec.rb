require_relative 'session_helpers.rb'
require 'rails_helper'

feature 'Visitor signs up' do
  before (:each) do
    visit '/'
    click_link 'Sign up'
  end

  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password12345'
    expect(page).to have_content('Logout')
  end

  scenario 'with invalid email' do
    sign_up_with 'invalid_email', 'password'
    expect(page).to have_content('Sign in')
  end

  scenario 'with blank password' do
    sign_up_with 'valid@example.com', ''
    expect(page).to have_content('Sign in')
  end

end

feature 'Visitor logs out' do
  before (:each) do
    visit '/'
    User.create(username: "valid@example.com", password: 'password12345' )
    click_link 'Login'
  end

  scenario 'with valid email and password' do
    sign_in_with 'valid@example.com', 'password12345'
    expect(page).to have_content('Sign up')
  end

end