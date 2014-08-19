class Quiz < ActiveRecord::Base
  has_many :questions
  belongs_to :user
  accepts_nested_attributes_for :questions
  validates :user_id, presence: true
end
