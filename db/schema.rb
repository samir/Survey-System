# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110803185436) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "content",     :limit => 127
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.string   "content",    :limit => 511
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description", :limit => 511
    t.boolean  "is_active",                  :default => false
    t.boolean  "is_public",                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.integer  "choose"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_answers", ["question_id"], :name => "index_user_answers_on_question_id"
  add_index "user_answers", ["survey_id"], :name => "index_user_answers_on_survey_id"
  add_index "user_answers", ["user_id"], :name => "index_user_answers_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 127
    t.string   "email",           :limit => 127
    t.string   "avatar"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["password_digest"], :name => "index_users_on_password_digest", :unique => true

  create_table "watchers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
