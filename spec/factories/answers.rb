Factory.define :answer do |f|
  f.association :question
  f.content "Lorem ipsum dolor sit amet"
end