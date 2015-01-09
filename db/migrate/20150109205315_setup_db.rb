class SetupDb < ActiveRecord::Migration
  def change

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
  end

 add_index "sessions", ["project_id"], name: "index_sessions_on_project_id"
 add_index "sessions", ["task_id"], name: "index_sessions_on_task_id"

  create_table "tasks", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

 add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"
 add_index "tasks", ["project_id"], name: "index_projects_on_project_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",			default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active",			default: true
  end
  end
end
