require 'faker'

FactoryGirl.define do
  factory :choice do |f|
    f.title {Faker::name}
    f.correct [true, false].sample
    f.question_id {Faker::Number.number(5)}
  end 
end 