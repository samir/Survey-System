require 'spec_helper'

describe Survey do

  before :each do
    @survey = Factory(:survey)
  end

  context "requirements" do
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:string) }
    it { should have_db_column(:is_active).of_type(:boolean) }
    it { should have_db_column(:is_public).of_type(:boolean) }
  end

  describe "validations" do
    it { should validate_presence_of :title }
    it { should ensure_length_of(:title).is_at_least(1).is_at_most(127) }
    it { should ensure_length_of(:description).is_at_most(511) }
  end

  context "associations" do
    it { should belong_to(:user) }
    it { should have_many(:questions) }
    it { should have_many(:watchers) }
    it { should have_many(:user_answers) }
  end

  describe "Behaviour" do
    it "should be a Survey object" do
      @survey.should be_instance_of(Survey)
    end
    it "should return user_id's array that user is watching" do
      @survey.users_watching.should be_an(Array)
    end
  end

end
