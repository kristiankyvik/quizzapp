require 'faker'

FactoryGirl.define do
  factory :quiz do |f|
    f.title {Faker::name}
    f.user_id {Faker::Number.number(5)}
  end 
end 