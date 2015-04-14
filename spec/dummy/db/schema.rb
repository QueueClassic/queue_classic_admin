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

ActiveRecord::Schema.define(version: 20130627175128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "queue_classic_jobs", id: :bigserial, force: :cascade do |t|
    t.text     "q_name",                         null: false
    t.text     "method",                         null: false
    t.json     "args",                           null: false
    t.datetime "locked_at"
    t.integer  "locked_by"
    t.datetime "created_at",   default: "now()"
    t.datetime "scheduled_at", default: "now()"
  end

  add_index "queue_classic_jobs", ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)", using: :btree
  add_index "queue_classic_jobs", ["scheduled_at", "id"], name: "idx_qc_on_scheduled_at_only_unlocked", where: "(locked_at IS NULL)", using: :btree

end
