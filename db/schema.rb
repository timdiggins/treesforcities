# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090728130512) do

  create_table "comments", :force => true do |t|
    t.integer  "lot_id"
    t.text     "text"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lots", :force => true do |t|
    t.string   "project"
    t.string   "site_street"
    t.string   "exact_loc"
    t.string   "land_ownership"
    t.string   "borough"
    t.string   "ward"
    t.string   "postcode"
    t.float    "geo_x"
    t.float    "geo_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tree_id"
  end

  create_table "trees", :force => true do |t|
    t.string   "tree_no"
    t.date     "date_planted"
    t.string   "project"
    t.string   "site_street"
    t.string   "exact_loc"
    t.string   "land_ownership"
    t.string   "borough"
    t.string   "ward"
    t.string   "species"
    t.string   "common_name"
    t.string   "postcode"
    t.float    "geo_x"
    t.float    "geo_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lot_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                    :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "editor",                                   :default => false
    t.boolean  "admin",                                    :default => true
    t.integer  "login_count",                              :default => 0
    t.datetime "last_login_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
