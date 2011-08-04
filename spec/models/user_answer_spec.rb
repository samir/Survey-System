require 'spec_helper'

describe UserAnswer do

  context "requirements" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:survey_id).of_type(:integer) }
    it { should have_db_column(:question_id).of_type(:integer) }
    it { should have_db_column(:answer_id).of_type(:integer) }
    it { should have_db_column(:comment).of_type(:string) }
  end

  context "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:survey) }
    it { should belong_to(:question) }
    it { should belong_to(:answer) }
  end

end
