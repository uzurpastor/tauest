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

ActiveRecord::Schema[7.0].define(version: 2022_06_21_190839) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answer_options", force: :cascade do |t|
    t.integer "question_id"
    t.boolean "right", default: false
    t.text "name"
  end

  create_table "answer_users", id: false, force: :cascade do |t|
    t.bigserial "id", null: false
    t.integer "answer_option_id"
    t.string "answer"
    t.boolean "right"
    t.integer "passed_test_id", null: false
  end

  create_table "answer_users_200", id: false, force: :cascade do |t|
    t.bigint "id", default: -> { "nextval('answer_users_id_seq'::regclass)" }, null: false
    t.integer "answer_option_id"
    t.string "answer"
    t.boolean "right"
    t.integer "passed_test_id", null: false
    t.check_constraint "passed_test_id > 100 AND passed_test_id <= 200", name: "answer_users_200_passed_test_id_check"
  end

  create_table "answer_users_old", id: :bigint, default: -> { "nextval('answer_users_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "answer_option_id"
    t.string "answer"
    t.boolean "right"
    t.integer "passed_test_id", null: false
    t.check_constraint "passed_test_id > 0 AND passed_test_id <= 100", name: "answer_users_old"
  end

  create_table "passed_tests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_id"
    t.integer "pass"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "test_id"
    t.string "name"
  end

  create_table "stars", force: :cascade do |t|
    t.integer "user_id"
    t.integer "test_id"
  end

  create_table "tests", force: :cascade do |t|
    t.integer "user_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "is_author", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answer_options", "questions", on_delete: :cascade
  add_foreign_key "answer_users", "answer_options", on_delete: :cascade
  add_foreign_key "answer_users", "passed_tests", on_delete: :cascade
  add_foreign_key "answer_users_200", "answer_options", on_delete: :cascade
  add_foreign_key "answer_users_200", "passed_tests", on_delete: :cascade
  add_foreign_key "answer_users_old", "answer_options", on_delete: :cascade
  add_foreign_key "answer_users_old", "passed_tests", on_delete: :cascade
  add_foreign_key "passed_tests", "tests", on_delete: :cascade
  add_foreign_key "passed_tests", "users", on_delete: :cascade
  add_foreign_key "questions", "tests", on_delete: :cascade
  add_foreign_key "stars", "tests", on_delete: :cascade
  add_foreign_key "stars", "users"
  add_foreign_key "tests", "users", on_delete: :cascade
end
