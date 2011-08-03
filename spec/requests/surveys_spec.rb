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
      
      click_button "Submit"

      page.should have_content("Successfully created survey.")
      page.should have_content("Show survey")
      page.should have_content("Title of Survey")
      page.should have_content("Long description of survey")

    end
  end

end
