require 'spec_helper'

describe User do

  before :each do
    @user = Factory(:user)
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

  describe "the signup process", :type => :request do
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

  describe "" do
    let(:user) { Factory(:user) }

    it "generates a unique password_reset_token each time" do
    end

    it "saves the time the password reset was sent" do
    end

    it "delivers email to user" do
    end
  end
end
