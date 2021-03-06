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

ActiveRecord::Schema.define(version: 20160414085415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer  "destination_id"
    t.integer  "kit_id"
    t.date     "check_in"
    t.integer  "adults"
    t.integer  "children"
    t.string   "contact"
    t.text     "note"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "bookings", ["destination_id"], name: "index_bookings_on_destination_id", using: :btree
  add_index "bookings", ["kit_id"], name: "index_bookings_on_kit_id", using: :btree

  create_table "certificates", force: :cascade do |t|
    t.decimal  "price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "approved_on"
    t.string   "code_prefix"
    t.integer  "company_id"
    t.string   "name"
    t.integer  "expires_in"
    t.integer  "duration"
    t.string   "slug"
    t.boolean  "global",      default: false
  end

  add_index "certificates", ["company_id"], name: "index_certificates_on_company_id", using: :btree
  add_index "certificates", ["slug"], name: "index_certificates_on_slug", using: :btree

  create_table "certificates_destinations", id: false, force: :cascade do |t|
    t.integer "certificate_id", null: false
    t.integer "destination_id", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "owner",      default: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.integer  "certificate_id"
    t.text     "title"
    t.text     "sub_title"
    t.text     "terms"
    t.text     "policies"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "banner"
  end

  add_index "contents", ["certificate_id"], name: "index_contents_on_certificate_id", using: :btree

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

  create_table "destinations", force: :cascade do |t|
    t.string   "name"
    t.string   "banner"
    t.text     "content"
    t.boolean  "active",     default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "location"
    t.string   "country"
    t.string   "slug"
    t.boolean  "featured",   default: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "kits", force: :cascade do |t|
    t.string   "code"
    t.integer  "certificate_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "used",           default: false, null: false
    t.date     "activated_on"
    t.integer  "user_id"
    t.date     "booked_on"
    t.integer  "company_id"
  end

  add_index "kits", ["certificate_id"], name: "index_kits_on_certificate_id", using: :btree
  add_index "kits", ["code"], name: "index_kits_on_code", using: :btree
  add_index "kits", ["company_id"], name: "index_kits_on_company_id", using: :btree
  add_index "kits", ["user_id"], name: "index_kits_on_user_id", using: :btree

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

  create_table "purchases", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "payment_id"
    t.integer  "certificate_id"
    t.boolean  "paid",           default: false
  end

  add_index "purchases", ["certificate_id"], name: "index_purchases_on_certificate_id", using: :btree
  add_index "purchases", ["user_id"], name: "index_purchases_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "name"
    t.string   "email",                                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,                 null: false
    t.boolean  "admin",                          default: false
    t.integer  "company_id"
    t.string   "role"
    t.string   "phone"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "bookings", "destinations"
  add_foreign_key "bookings", "kits"
  add_foreign_key "certificates", "companies"
  add_foreign_key "contents", "certificates"
  add_foreign_key "kits", "certificates"
  add_foreign_key "kits", "companies"
  add_foreign_key "kits", "users"
  add_foreign_key "orders", "certificates"
  add_foreign_key "orders", "users"
  add_foreign_key "purchases", "certificates"
  add_foreign_key "purchases", "users"
  add_foreign_key "users", "companies"
end
