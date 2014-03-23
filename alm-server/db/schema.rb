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

ActiveRecord::Schema.define(version: 20140323033049) do

  create_table "affinities", force: true do |t|
    t.integer  "from_device_id",             null: false
    t.integer  "to_device_id",               null: false
    t.integer  "level",          default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "device_locations", force: true do |t|
    t.integer  "device_id"
    t.string   "hue_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.string   "device_id",    null: false
    t.integer  "major_id"
    t.string   "device_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "device_id"
    t.integer  "question"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["device_id", "question"], name: "index_questions_on_device_id_and_question", using: :btree

end
