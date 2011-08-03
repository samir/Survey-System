class Watcher < ActiveRecord::Base

  # Relationship
  belongs_to :user
  belongs_to :survey

  # Validations
  validates_associated :user
  validates_associated :survey

end
