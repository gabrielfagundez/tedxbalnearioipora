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

ActiveRecord::Schema.define(version: 20160718215858) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "billable",   default: true
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "account_id"
    t.text     "description"
  end

  create_table "clients_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client_id"
  end

  create_table "favorite_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "event_type"
    t.datetime "expected_date"
    t.integer  "project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "mision"
    t.text     "vision"
    t.integer  "client_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "hired_hours"
    t.integer  "expected_hours"
    t.integer  "team_leader_id"
    t.string   "daily_meeting"
    t.string   "retrospectives"
    t.string   "iteration_planning"
    t.string   "estimates_model"
    t.string   "issue_tracker"
    t.string   "contract_end_date"
    t.string   "code_review_model"
    t.boolean  "billable"
    t.string   "color"
    t.text     "summary"
    t.integer  "velocity_frequency_in_days", default: 7
  end

  create_table "projects_team_members", force: :cascade do |t|
    t.integer "project_id"
    t.integer "team_member_id"
  end

  create_table "story_points", force: :cascade do |t|
    t.string  "value"
    t.text    "definition"
    t.integer "project_id"
  end

  create_table "team_members", force: :cascade do |t|
    t.string   "name"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "toggl_name"
  end

  create_table "time_categories", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "description"
    t.integer  "time_category_id"
    t.boolean  "billable"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer  "duration"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "user_events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "event_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.integer  "account_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "velocity_registers", force: :cascade do |t|
    t.string   "period"
    t.integer  "points"
    t.integer  "project_id"
    t.integer  "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weekly_entries", force: :cascade do |t|
    t.integer  "team_member_id"
    t.integer  "project_id"
    t.string   "week"
    t.decimal  "communication"
    t.decimal  "development"
    t.decimal  "bugs"
    t.decimal  "code_review"
    t.decimal  "qa"
    t.decimal  "infraestructure"
    t.decimal  "uxui"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  create_table "weekly_time_entries", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "time_category_id"
    t.string   "week"
    t.decimal  "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "widgets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "widget_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
