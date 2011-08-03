class User < ActiveRecord::Base
  
  has_secure_password
  before_create { generate_token(:auth_token) }

  # Relationship
  has_many :surveys
  has_many :watchers, :dependent => :destroy
  
  # Accessors
  mount_uploader :avatar, AvatarUploader
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :avatar_cache

  # Validations
  validates_presence_of :email, :name
  validates_presence_of :password, :on => :create
  validates_length_of :name, :in => 1..127
  validates_length_of :email, :in => 1..127
  validates_uniqueness_of :email
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def watching
    self.watchers.map{|item| item.survey_id}
  end

end
