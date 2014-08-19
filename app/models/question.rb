class Question < ActiveRecord::Base
  has_many :choices
  belongs_to :quiz
  accepts_nested_attributes_for :choices
  validates :quiz_id, presence: true
  validates :choices, :length => {:maximum => 4}
end
