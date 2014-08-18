require 'rails_helper'

describe 'visiting the homepage', :type => :feature do
  before do
    visit '/'
  end

  it 'should have a body' do
    page.has_css?("exist")
    page.should have_content('ola q ase')    
  end
end
