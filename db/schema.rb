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

ActiveRecord::Schema.define(:version => 20120131072934) do

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "superuser",      :default => false
    t.boolean  "manage_roles",   :default => false
    t.boolean  "add_sermons",    :default => false
    t.boolean  "edit_sermons",   :default => false
    t.boolean  "delete_sermons", :default => false
    t.boolean  "add_edit_users", :default => false
    t.boolean  "delete_users",   :default => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "sermons", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.string   "passage"
    t.string   "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "audio_path"
    t.integer  "speaker_id"
    t.integer  "service_id"
  end

  add_index "sermons", ["date"], :name => "index_sermons_on_date"

  create_table "sermons_tags", :force => true do |t|
    t.integer "sermon_id"
    t.integer "tag_id"
  end

  add_index "sermons_tags", ["sermon_id"], :name => "index_sermons_tags_on_sermon_id"
  add_index "sermons_tags", ["tag_id"], :name => "index_sermons_tags_on_tag_id"

  create_table "services", :force => true do |t|
    t.string "name"
  end

  add_index "services", ["name"], :name => "index_services_on_name"

  create_table "speakers", :force => true do |t|
    t.string "name"
  end

  add_index "speakers", ["name"], :name => "index_speakers_on_name"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.integer  "role_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
