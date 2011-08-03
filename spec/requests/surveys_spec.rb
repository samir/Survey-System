require 'spec_helper'

describe "Surveys" do

  before :each do
    User.create(:name => "User Example", :email => 'user@example.com', :password => '123')
  end

  describe "GET /surveys" do

    it "redirect if user not logged in" do
      visit surveys_path
      current_path.should eq(login_path)
    end

    it "log in and see My Surveys" do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "123"
      click_button "Log in"

      visit surveys_path
      page.should have_content("My Surveys")
      current_path.should eq(surveys_path)
    end
  end

  describe "POST /surveys" do
    it "create a survey" do
      visit login_path
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "123"
      click_button "Log in"

      visit new_survey_path
      page.should have_content("Add survey")
      
      fill_in "Title", :with => "Title of Survey"
      fill_in "Description", :with => "Long description of survey"

      fill_in "survey[questions_attributes][0][content]", :with => "Q1"
      fill_in "survey[questions_attributes][0][answers_attributes][0][content]", :with => "Q1A1"
      fill_in "survey[questions_attributes][0][answers_attributes][1][content]", :with => "Q1A2"
      fill_in "survey[questions_attributes][0][answers_attributes][2][content]", :with => "Q1A3"
      fill_in "survey[questions_attributes][0][answers_attributes][3][content]", :with => "Q1A4"
      
      fill_in "survey[questions_attributes][1][content]", :with => "Q2"
      fill_in "survey[questions_attributes][1][answers_attributes][0][content]", :with => "Q2A1"
      fill_in "survey[questions_attributes][1][answers_attributes][1][content]", :with => "Q2A2"
      fill_in "survey[questions_attributes][1][answers_attributes][2][content]", :with => "Q2A3"
      fill_in "survey[questions_attributes][1][answers_attributes][3][content]", :with => "Q2A4"
      
      click_button "Submit"

      page.should have_content("Survey was successfully created.")

      page.should have_content("Show survey")

      page.should have_content("Title of Survey")
      page.should have_content("Long description of survey")
      page.should have_content("Q1A1")
      page.should have_content("Q2A4")

    end
  end

end
