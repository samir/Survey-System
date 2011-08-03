# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

txt_description = []
txt_description << "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
txt_description << "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
txt_description << "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

txt_question = []
txt_question << "Lorem ipsum dolor sit amet?"
txt_question << "Consectetur adipisicing elit?"
txt_question << "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua?"
txt_question << "Ut enim ad minim veniam?"
txt_question << "Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat?"
txt_question << "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur?"
txt_question << "Excepteur sint occaecat cupidatat non proident?"
txt_question << "Sunt in culpa qui officia deserunt mollit anim id est laborum?"

txt_answer = []
txt_answer << [100,222,349,409]
txt_answer << ['two','eleven','nine','one hundred']
txt_answer << ['Lorem ipsum dolor','sit amet, consectetur','adipisicing elit','sed do eiusmod tempor']
txt_answer << ['incididunt ut','labore et dolore','magna aliqua','Ut enim ad minim veniam']
txt_answer << ['quis nostrud exercitation','ullamco laboris nisi','ut aliquip ex ea','commodo consequat']
txt_answer << ['Duis aute irure dolor','in reprehenderit','in voluptate velit','esse cillum dolore']
txt_answer << ['eu fugiat nulla','pariatur','Excepteur','sint occaecat']
txt_answer << ['cupidatat','non proident','sunt in culpa','qui officia']


# Clear tables
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  puts "Cleaning #{table}"
  ActiveRecord::Base.connection.execute("DELETE FROM #{table}") unless table == 'schema_migrations'
  ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
end
ActiveRecord::Base.connection.execute("VACUUM")


puts "=" * 80
puts "Creating users"
users = User.create!([{:name => "User #1", :email => "user1@example.com", :password => "123", :avatar => File.open("#{Rails.root}/tmp/seed/user1.jpg")},
                      {:name => "User #2", :email => "user2@example.com", :password => "123", :avatar => File.open("#{Rails.root}/tmp/seed/user2.jpg")},
                      {:name => "User #3", :email => "user3@example.com", :password => "123", :avatar => File.open("#{Rails.root}/tmp/seed/user3.jpg")}])

surveys = []
puts "Creating surveys"
f = 0
users.each do |user|
  f = f + 1; surveys << Survey.create!(:user => user, :title => "Survey #{f}", :description => txt_description[f%3], :is_active => true, :is_public => true)
  f = f + 1; surveys << Survey.create!(:user => user, :title => "Survey #{f}", :description => txt_description[f%3], :is_active => true, :is_public => true)
  f = f + 1; surveys << Survey.create!(:user => user, :title => "Survey #{f}", :description => txt_description[f%3], :is_active => true, :is_public => true)
end

questions = []
puts "Creating questions"
f = 0
surveys.each_with_index do |survey,i|
  f = f + 1; questions << Question.create!(:survey => survey, :content => txt_question[f%8])
  f = f + 1; questions << Question.create!(:survey => survey, :content => txt_question[f%8])
  f = f + 1; questions << Question.create!(:survey => survey, :content => txt_question[f%8])
  f = f + 1; questions << Question.create!(:survey => survey, :content => txt_question[f%8])
end

answers = []
puts "Creating answers"
f = 0
questions.each_with_index do |question,i|
  f = f + 1
  answers << Answer.create!([{:question => question, :content => txt_answer[f%8][0]},
                             {:question => question, :content => txt_answer[f%8][1]},
                             {:question => question, :content => txt_answer[f%8][2]},
                             {:question => question, :content => txt_answer[f%8][3]}])
end

puts "Creating watchers lists"
Watcher.create!([{:user_id => 2, :survey_id => 1},
                 {:user_id => 2, :survey_id => 2},
                 {:user_id => 3, :survey_id => 3},
                 {:user_id => 3, :survey_id => 4},
                 {:user_id => 3, :survey_id => 5},
                 {:user_id => 1, :survey_id => 6},
                 {:user_id => 1, :survey_id => 7},
                 {:user_id => 1, :survey_id => 8},
                 {:user_id => 2, :survey_id => 9}])


puts "=" * 80

puts "Modifying survey's created_at date"
range = [3,10,30,40,60,100,200,300,400]
Survey.all.each_with_index do |survey,i|
  survey.created_at = range[i].days.ago
  survey.save
end
