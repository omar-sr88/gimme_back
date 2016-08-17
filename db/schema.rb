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

ActiveRecord::Schema.define(version: 20160814232132) do

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.date     "date_lended"
    t.integer  "owner_id"
    t.integer  "recipient_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "initial_return_date"
    t.date     "returned_date"
    t.index ["owner_id", "created_at"], name: "index_items_on_owner_id_and_created_at"
    t.index ["owner_id"], name: "index_items_on_owner_id"
    t.index ["recipient_id", "created_at"], name: "index_items_on_recipient_id_and_created_at"
    t.index ["recipient_id"], name: "index_items_on_recipient_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "nick"
    t.boolean  "super",              default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",          default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "updated_since_sent", default: false
    t.string   "type",               default: "User"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
