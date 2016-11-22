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

ActiveRecord::Schema.define(version: 20161102174312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string   "section"
    t.string   "time_slot"
    t.string   "company"
    t.string   "student"
    t.string   "UIN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "contact_person"
    t.string   "contact_email"
    t.string   "sponsor_level"
    t.string   "citizenship"
    t.string   "job_type"
    t.string   "student_level"
    t.string   "rep_1"
    t.string   "rep_2"
    t.string   "rep_3"
    t.string   "rep_4"
    t.string   "rep_5"
    t.string   "rep_6"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "companyevents", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "event_id"
    t.integer  "representatives"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_students"
    t.boolean  "for_student"
    t.boolean  "for_company"
    t.date     "event_date"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "timeslot_duration"
    t.boolean  "editable",          default: true
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "UIN"
    t.string   "email"
    t.boolean  "US_Citizen"
    t.string   "degree"
    t.string   "position_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "edithash"
  end

  create_table "students_timeslots", id: false, force: :cascade do |t|
    t.integer "student_id",  null: false
    t.integer "timeslot_id", null: false
  end

  create_table "timeslots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "stunum"
    t.integer  "event_id"
  end

  add_index "timeslots", ["event_id"], name: "index_timeslots_on_event_id", using: :btree

  create_table "useradds", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "useradds", ["email"], name: "index_useradds_on_email", unique: true, using: :btree

  add_foreign_key "timeslots", "events"
end
