class User < ActiveRecord::Base
  
  mount_uploader :avatar, AvatarUploader
  
  attr_accessible :name, :email, :password, :password_confirmation, :avatar, :avatar_cache
  has_secure_password
  before_create { generate_token(:auth_token) }

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

end
