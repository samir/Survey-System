require 'spec_helper'

describe Answer do

  context "requirements" do
    it { should have_db_column(:content).of_type(:string) }
  end

  describe "validations" do
    it { should validate_presence_of :content }
    it { should ensure_length_of(:content).is_at_least(1).is_at_most(127) }
  end

  context "associations" do
    it { should have_many(:user_answers) }
    it { should belong_to(:question) }
  end

end
