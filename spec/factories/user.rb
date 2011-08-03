Factory.define :user do |f|
  f.sequence(:name) { |n| "User Name ##{n}" }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.password "123"
  f.password_digest "$2a$10$JotYAjf8TLNiLSDYklhspOzgMV9hwLE05SeYXrWb4v8ESejYTttLa" # 123
end