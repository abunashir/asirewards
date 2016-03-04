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

ActiveRecord::Schema.define(version: 20160304102817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.string   "banner"
    t.text     "title"
    t.text     "sub_title"
    t.text     "terms"
    t.date     "expires_on"
    t.decimal  "price"
    t.text     "policies"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.date     "approved_on"
  end

  add_index "certificates", ["user_id"], name: "index_certificates_on_user_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "distributions", force: :cascade do |t|
    t.integer  "kit_id"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.integer  "sender_id"
    t.date     "activated_on"
  end

  add_index "distributions", ["kit_id"], name: "index_distributions_on_kit_id", using: :btree

  create_table "kits", force: :cascade do |t|
    t.string   "code"
    t.integer  "certificate_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "used",           default: false, null: false
  end

  add_index "kits", ["certificate_id"], name: "index_kits_on_certificate_id", using: :btree
  add_index "kits", ["code"], name: "index_kits_on_code", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "certificate_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.text     "note"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "approved_on"
  end

  add_index "orders", ["certificate_id"], name: "index_orders_on_certificate_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name"
    t.string   "email",                                          null: false
    t.string   "encrypted_password", limit: 128,                 null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,                 null: false
    t.boolean  "admin",                          default: false
    t.integer  "company_id"
    t.string   "role"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "certificates", "users"
  add_foreign_key "distributions", "kits"
  add_foreign_key "kits", "certificates"
  add_foreign_key "orders", "certificates"
  add_foreign_key "orders", "users"
  add_foreign_key "users", "companies"
end
