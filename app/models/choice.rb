class Choice < ActiveRecord::Base
  belongs_to :question
  # validates :correct, :inclusion => {:in => [true, false]}       
end
