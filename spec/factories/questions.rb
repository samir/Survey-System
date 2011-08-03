Factory.define :question do |f|
  f.association :survey
  f.content "Lorem ipsum dolor sit amet"
end