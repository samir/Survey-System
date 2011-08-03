class Question < ActiveRecord::Base

  # Relationship
  belongs_to :survey
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_many :user_answers

  # Validations
  validates_presence_of :content
  validates_length_of :content, :in => 1..511

end
