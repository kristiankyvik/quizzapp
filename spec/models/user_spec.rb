require 'rails_helper'

RSpec.describe User, :type => :model do
  it "has a valid factory" do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    expect(FactoryGirl.build(:user, email: nil)).not_to be_valid 
  end

  it "is invalid without a valid username" do
    expect(FactoryGirl.build(:user, email: 'sdsdfds@dsds')).not_to be_valid 
  end

end
