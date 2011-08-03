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

end
