require 'spec_helper'

describe ApplicationHelper do
  pending "#link_to_add_fields" 
  # describe "#link_to_add_fields" do
  #   it "should return set of tags to add group of nested fields" do
  #     @survey = Survey.new
  #     helper.simple_form_for @survey do |f|
  #       content = helper.link_to_add_fields("Remove", f, :questions)
  #       content.should == 'x'
  #     end
  #   end
  # end

  describe "#link_to_remove_fields" do
    it "should return set of tags to remove group of nested fields" do
      @survey = Survey.new
      helper.simple_form_for @survey do |f|
        content = helper.link_to_remove_fields("Remove", f)
        content.should == '<input class="hidden" id="survey__destroy" name="survey[_destroy]" type="hidden" value="false" /><a class="remove_link" href="#" onclick="remove_fields(this); return false;">Remove</a>'
      end
    end
  end
  
  describe "#error_messages" do
    it "should return box with error messages" do
      @user = User.new
      @user.save
      content = helper.error_messages(@user)
      content.should =~ /Form is invalid/
      content.should =~ /Name can't be blank/
    end
  end
  
  describe "#watch_button" do
    it "should render link to watch/unwatch survey" do
      @survey = Survey.create!({:user_id => 1, :title => "title", :description => "description"})
      content = helper.watch_button(@survey)
      content.should =~ /<a href="\/surveys\/set_watching\?_=0.([0-9]+)&amp;id=#{@survey.id}" data-method="post" data-remote="true" id="watch_link_#{@survey.id}" rel="nofollow">Watch<\/a>/
    end
  end

end
