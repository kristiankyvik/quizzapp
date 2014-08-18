require 'rails_helper'


RSpec.describe Choice, :type => :model do
   it "factory is valid" do
    expect(FactoryGirl.build(:choice)).to be_valid
  end

  it "factory with no choice is invalid" do
    expect(FactoryGirl.build(:choice, question_id: nil)).not_to be_valid
  end

  it "factory with no choice is invalid" do
    expect(FactoryGirl.build(:choice, correct: nil)).not_to be_valid
  end


end
