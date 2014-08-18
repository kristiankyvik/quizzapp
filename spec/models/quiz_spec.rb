require 'rails_helper'

RSpec.describe Quiz, :type => :model do
  it "not valid if not tied to user" do
    expect(FactoryGirl.build(:quiz)).to be_valid
  end
end
