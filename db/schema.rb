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

ActiveRecord::Schema.define(:version => 20130311030104) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",             :limit => 60
    t.string   "last_name",              :limit => 60
    t.integer  "user_id"
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

  add_index "admin_users", ["confirmation_token"], :name => "index_admin_users_on_confirmation_token", :unique => true
  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true
  add_index "admin_users", ["unlock_token"], :name => "index_admin_users_on_unlock_token", :unique => true

  create_table "block_requests", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "user_id",       :null => false
    t.integer  "source_id",     :null => false
    t.string   "source_type",   :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "block_requests", ["source_id", "source_type"], :name => "index_block_requests_on_source_id_and_source_type"
  add_index "block_requests", ["user_id"], :name => "index_block_requests_on_user_id"

  create_table "churches", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.string   "homepage",   :limit => 100, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "group_memberships", :force => true do |t|
    t.integer  "group_id",                     :null => false
    t.integer  "user_id",                      :null => false
    t.boolean  "is_public",  :default => true
    t.integer  "role_level", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "group_memberships", ["group_id", "user_id"], :name => "index_group_memberships_on_group_id_and_user_id"
  add_index "group_memberships", ["user_id", "is_public"], :name => "index_group_memberships_on_user_id_and_is_public"

  create_table "groups", :force => true do |t|
    t.string   "state",            :limit => 50,                   :null => false
    t.string   "name",                                             :null => false
    t.text     "desription",                                       :null => false
    t.boolean  "is_public",                      :default => true
    t.integer  "meets_every_days",               :default => 7
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "groups", ["state", "is_public"], :name => "index_groups_on_state_and_is_public"

  create_table "lessons", :force => true do |t|
    t.integer  "series_id",                  :null => false
    t.integer  "position",    :default => 0
    t.string   "title",                      :null => false
    t.text     "description"
    t.string   "backlink"
    t.string   "video_url"
    t.string   "audio_url"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "lessons", ["series_id", "position"], :name => "index_lessons_on_series_id_and_position"

  create_table "meetings", :force => true do |t|
    t.integer  "group_id",                 :null => false
    t.integer  "lesson_id",                :null => false
    t.string   "state",      :limit => 50, :null => false
    t.datetime "date_of"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "meetings", ["group_id", "state"], :name => "index_meetings_on_group_id_and_state"
  add_index "meetings", ["lesson_id"], :name => "index_meetings_on_lesson_id"

  create_table "podcasts", :force => true do |t|
    t.integer  "church_id",                   :null => false
    t.string   "title",        :limit => 100
    t.string   "url",                         :null => false
    t.datetime "last_checked"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "podcasts", ["church_id"], :name => "index_podcasts_on_church_id"

  create_table "questions", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.integer  "source_id",                    :null => false
    t.string   "source_type",                  :null => false
    t.text     "text",                         :null => false
    t.integer  "answers_count", :default => 0
    t.integer  "blocked_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "questions", ["source_id", "source_type"], :name => "index_questions_on_source_id_and_source_type"

  create_table "series", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "podcast_id",                   :null => false
    t.string   "title",                        :null => false
    t.string   "description"
    t.string   "ref_link"
    t.string   "video_url"
    t.integer  "lessons_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "series", ["podcast_id"], :name => "index_series_on_podcast_id"
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
