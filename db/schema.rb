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

ActiveRecord::Schema.define(version: 20150815232401) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.string   "company_name"
    t.text     "description"
    t.boolean  "expired"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.string   "company_url"
    t.string   "company_email"
    t.string   "address"
    t.text     "apply_process"
    t.datetime "completed_at"
    t.datetime "deleted_at"
    t.integer  "category_id"
  end

  add_index "jobs", ["category_id"], name: "index_jobs_on_category_id"
  add_index "jobs", ["deleted_at"], name: "index_jobs_on_deleted_at"

end
