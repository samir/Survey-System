require 'spec_helper'

describe Watcher do

  context "requirements" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:survey_id).of_type(:integer) }
  end

end
