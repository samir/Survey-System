class Survey < ActiveRecord::Base

  # Relationship
  belongs_to :user
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  # Validations
  validates_presence_of :title
  validates_length_of :title, :in => 1..127
  validates_length_of :description, :maximum => 511

end
