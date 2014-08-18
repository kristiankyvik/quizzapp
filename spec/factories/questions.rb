require 'faker'

FactoryGirl.define do
  factory :question do |f|
    f.title {Faker::name}
    f.song {Faker::Code.ean}
    f.explanation {Faker::Company.catch_phrase}
    f.quiz_id {Faker::Number.number(5)}
  end 
end 