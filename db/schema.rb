# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130303050220) do

  create_table "admins", :force => true do |t|
    t.string   "first_name",             :limit => 60
    t.string   "last_name",              :limit => 60
    t.string   "email",                  :limit => 80, :default => "", :null => false
    t.string   "encrypted_password",                   :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                      :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "public"
    t.integer  "role_level", :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "group_memberships", ["group_id", "user_id"], :name => "index_group_memberships_on_group_id_and_user_id"
  add_index "group_memberships", ["user_id", "public"], :name => "index_group_memberships_on_user_id_and_public"

  create_table "groups", :force => true do |t|
    t.integer  "meeting_id"
    t.string   "name"
    t.text     "desription"
    t.boolean  "public"
    t.integer  "meets_every_days", :default => 7
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "groups", ["meeting_id"], :name => "index_groups_on_meeting_id"

  create_table "meetings", :force => true do |t|
    t.integer  "group_id"
    t.integer  "lesson_id"
    t.datetime "date_of"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "meetings", ["group_id", "date_of"], :name => "index_meetings_on_group_id_and_date_of"
  add_index "meetings", ["lesson_id"], :name => "index_meetings_on_lesson_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "source_id"
    t.string   "source_type"
    t.text     "text"
    t.integer  "answers_count"
    t.integer  "blocked_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "questions", ["source_id", "source_type"], :name => "index_questions_on_source_id_and_source_type"

  create_table "series", :force => true do |t|
    t.string   "slug",                         :null => false
    t.string   "title",                        :null => false
    t.string   "description"
    t.string   "ref_link"
    t.string   "video_url"
    t.integer  "lessons_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "series", ["slug"], :name => "index_series_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name",                 :limit => 60
    t.string   "last_name",                  :limit => 60
    t.string   "email",                      :limit => 80, :default => "", :null => false
    t.string   "encrypted_password",                       :default => "", :null => false
    t.string   "password_salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                            :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                          :default => 0
    t.datetime "locked_at"
    t.string   "profile_image_file_name"
    t.string   "profile_image_content_type"
    t.integer  "profile_image_file_size"
    t.datetime "profile_image_updated_at"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
