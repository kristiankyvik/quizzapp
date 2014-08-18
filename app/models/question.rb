class Question < ActiveRecord::Base
  has_many :choices
  belongs_to :quiz
  accepts_nested_attributes_for :choices
end
