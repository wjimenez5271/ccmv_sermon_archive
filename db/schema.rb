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

ActiveRecord::Schema.define(:version => 20120125041601) do

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.boolean  "superuser"
    t.boolean  "manage_roles"
    t.boolean  "add_sermons"
    t.boolean  "edit_sermons"
    t.boolean  "delete_sermons"
    t.boolean  "add_edit_users"
    t.boolean  "delete_users"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "sermons", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.string   "passage"
    t.string   "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "audio_path"
  end

  create_table "sermons_tags", :force => true do |t|
    t.integer "sermon_id"
    t.integer "tag_id"
  end

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

  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
