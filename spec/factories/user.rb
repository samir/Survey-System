Factory.define :user do |u|
  u.sequence(:name) {|n| "User Name ##{n}"}
  u.sequence(:email) {|n| "user#{n}@example.com"}
  u.password "123"
  # u.avatar File.open("#{Rails.root}/tmp/seed/user1.jpg")
  u.password_digest "$2a$10$JotYAjf8TLNiLSDYklhspOzgMV9hwLE05SeYXrWb4v8ESejYTttLa" # digest for 123
end
