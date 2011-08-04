require 'spec_helper'

describe User do

  before :each do
    @user = User.create!({:name => "User #1", :email => "user1@example.com", :password => 123})
  end

  context "requirements" do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:avatar).of_type(:string) }
    it { should have_db_index(:email).unique(true) }
    it { should have_db_index(:password_digest).unique(true) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should ensure_length_of(:name).is_at_least(1).is_at_most(127) }
    # it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context "associations" do
    it { should have_many(:surveys) }
    it { should have_many(:watchers) }
    it { should have_many(:user_answers) }
  end


  describe "The signup process", :type => :request do
    before :each do
      User.create!(:name => "User", :email => 'user@example.com', :password => 'caplin')
    end
    it "signs me in" do
      visit login_path
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => 'password'
      click_link 'Log in'
    end
  end

  describe "Behaviour" do
    it "should be an User object" do
      @user.should be_instance_of(User)
    end
    it "should save auth token with exact characters length" do
      @user[:auth_token].length.should == 22
    end
    it "should return survey_id's array that user is watching" do
      @user.watching.should be_an(Array)
    end
  end

end
