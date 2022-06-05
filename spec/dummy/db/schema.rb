# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2013_06_27_175128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "queue_classic_jobs", force: :cascade do |t|
    t.text "q_name", null: false
    t.text "method", null: false
    t.jsonb "args", null: false
    t.timestamptz "locked_at"
    t.integer "locked_by"
    t.timestamptz "created_at", default: -> { "now()" }
    t.timestamptz "scheduled_at", default: -> { "now()" }
    t.index ["q_name", "id"], name: "idx_qc_on_name_only_unlocked", where: "(locked_at IS NULL)"
    t.index ["scheduled_at", "id"], name: "idx_qc_on_scheduled_at_only_unlocked", where: "(locked_at IS NULL)"
    t.check_constraint "length(method) > 0", name: "queue_classic_jobs_method_check"
    t.check_constraint "length(q_name) > 0", name: "queue_classic_jobs_q_name_check"
  end

end
