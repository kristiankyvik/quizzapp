require_relative 'session_helpers.rb'
require 'rails_helper'

feature 'Create a quiz' do
  before (:each) do
    visit '/'
    click_link 'Sign in'
    sign_in_with 'valid@example.com', 'password12345'
  end
end