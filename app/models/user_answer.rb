class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  belongs_to :question
  belongs_to :answer
end
