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

ActiveRecord::Schema[8.0].define(version: 2025_08_06_073526) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "draw_players", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_draw_players_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.integer "price"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lucky_draw"
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "solid_queue_assignments", force: :cascade do |t|
    t.bigint "solid_queue_process_id"
    t.bigint "solid_queue_job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solid_queue_job_id"], name: "index_solid_queue_assignments_on_solid_queue_job_id"
    t.index ["solid_queue_process_id"], name: "index_solid_queue_assignments_on_solid_queue_process_id"
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "job_class", null: false
    t.text "arguments"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_jobs_on_queue_name"
    t.index ["scheduled_at"], name: "index_solid_queue_jobs_on_scheduled_at"
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "last_heartbeat_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_solid_queue_processes_on_name", unique: true
  end

  create_table "staff_members", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_staff_members_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "owner_name"
    t.integer "purse", default: 3000000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "draw_players", "teams"
  add_foreign_key "players", "teams"
  add_foreign_key "solid_queue_assignments", "solid_queue_jobs"
  add_foreign_key "solid_queue_assignments", "solid_queue_processes"
  add_foreign_key "staff_members", "teams"
end
