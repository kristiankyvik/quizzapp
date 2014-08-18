require 'rails_helper'

RSpec.describe Question, :type => :model do
  it "factory is valid" do
    expect(FactoryGirl.build(:question)).to be_valid
  end

  # it "needs to have fou" do
  #   expect(FactoryGirl.build(:question)).to be_valid
  # end




end
