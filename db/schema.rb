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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150125225335) do

  create_table "collaborators", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborators", ["project_id"], name: "index_collaborators_on_project_id"
  add_index "collaborators", ["user_id"], name: "index_collaborators_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "completion_date"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "sessions", force: true do |t|
    t.integer  "project_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "task_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
    t.integer  "user_id"
  end

  add_index "sessions", ["project_id"], name: "index_sessions_on_project_id"
  add_index "sessions", ["task_id"], name: "index_sessions_on_task_id"
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id"

  create_table "tasks", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_projects_on_project_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",          default: true
    t.string   "provider"
    t.string   "uid"
  end

end
