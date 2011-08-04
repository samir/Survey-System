require 'spec_helper'

describe Watcher do

  before :each do
    @watcher = Factory(:watcher)
  end

  context "requirements" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:survey_id).of_type(:integer) }
  end

  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:survey) }
  end

  describe "Behaviour" do
    it "should be a Watcher object" do
      @watcher.should be_instance_of(Watcher)
    end
  end

end
