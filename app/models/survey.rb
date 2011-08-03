class Survey < ActiveRecord::Base

  # Relationship
  belongs_to :user
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  has_many :watchers, :dependent => :destroy

  # Accessors
  attr_accessible :title, :description, :is_active, :is_public, :user, :questions_attributes

  # Validations
  validates_presence_of :title
  validates_length_of :title, :in => 1..127
  validates_length_of :description, :maximum => 511

  def users_watching
    self.watchers.map{|item| item.user_id}
  end

end
