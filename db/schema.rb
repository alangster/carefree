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

ActiveRecord::Schema.define(version: 20150213195543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: true do |t|
    t.decimal  "starting_total",  precision: 12, scale: 2
    t.decimal  "remaining_total", precision: 12, scale: 2
    t.integer  "budgetable_id"
    t.string   "budgetable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checklists", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cohort_members", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "cohort_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cohorts", force: true do |t|
    t.string   "name"
    t.string   "join_token"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",     default: false
  end

  create_table "conversation_members", id: false, force: true do |t|
    t.integer  "member_id"
    t.integer  "conversation_id"
    t.datetime "last_view"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_addresses", force: true do |t|
    t.integer  "office_id"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "state_abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", force: true do |t|
    t.text     "description"
    t.decimal  "cost",        precision: 12, scale: 2
    t.integer  "budget_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.text     "text"
    t.string   "file"
    t.integer  "conversation_id"
    t.integer  "sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "office_vendors", id: false, force: true do |t|
    t.integer  "office_id"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offices", force: true do |t|
    t.integer  "company_id"
    t.string   "phone"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "state_abbr"
    t.string   "join_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.text     "description"
    t.string   "picture"
    t.string   "file"
    t.integer  "checklist_id"
    t.integer  "assigner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "photo"
    t.integer  "office_id"
    t.integer  "role_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "admin"
  end

  create_table "vendor_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "state_abbr"
    t.integer  "vendor_cagory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
