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

ActiveRecord::Schema.define(version: 20160911120047) do

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "comment_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "user_id"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "comment_text", limit: 4294967295, null: false
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "project_id"
    t.string   "comment_type",                    null: false
  end

  create_table "likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "project_id"
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.string   "title"
    t.text     "description",   limit: 4294967295
    t.string   "time_required",                    default: "unknown", null: false
    t.string   "status",                           default: "unknown", null: false
    t.string   "url"
    t.boolean  "completed",                        default: false
    t.boolean  "approved",                         default: false
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "token_salt"
    t.datetime "valid_until"
    t.string   "token_final"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_sessions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "username",               null: false
    t.string   "password",               null: false
    t.string   "salt",                   null: false
    t.integer  "level",      default: 1, null: false
  end

  create_table "volunteers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id"
    t.integer  "user_id"
  end

end
