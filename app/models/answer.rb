class Answer < ActiveRecord::Base

  # Relationship
  belongs_to :question
  has_many :user_answers

  # Validations
  validates_presence_of :content
  validates_length_of :content, :in => 1..127

end
