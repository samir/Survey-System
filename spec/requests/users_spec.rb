require 'spec_helper'

describe "Users" do

  describe "GET /signup" do

    it "try to signup a user with invalid data and see Error message" do
      visit signup_path
      fill_in "Name", :with => "Samir Braga"
      fill_in "Email", :with => "samirbraga@gmail.com"
      fill_in "Password", :with => "123"
      fill_in "Password confirmation", :with => "1234"
      click_button "Create User"
      page.should have_content("Form is invalid")
    end

    it "signup a user redirect logged in to root" do
      visit signup_path
      fill_in "Name", :with => "User Example"
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "123"
      fill_in "Password confirmation", :with => "123"
      click_button "Create User"
      page.should have_content("Signed up and logged in!")
      current_path.should eq(root_path)
    end

  end

  describe "GET /login" do

    before :each do
      User.create(:name => "User Example", :email => 'user@example.com', :password => '123')
    end

    it "sign in a valid user" do
      visit login_path
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => '123'
      click_button 'Log in'
      page.should have_content("Logged in!")
    end

    it "not sign in a invalid user" do
      visit login_path
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => '123x'
      click_button 'Log in'
      page.should have_content("Invalid email or password")
    end

  end

  describe "GET /logout" do

    before :each do
      User.create(:name => "User Example", :email => 'user@example.com', :password => '123')
    end

    it "sign out successfuly" do
      visit login_path
      fill_in 'Email', :with => 'user@example.com'
      fill_in 'Password', :with => '123'
      click_button 'Log in'
      current_path.should eq(root_path)
      click_link "Log out"
      page.should have_content("Logged out!")
      current_path.should eq(root_path)
    end

  end

end


