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

ActiveRecord::Schema.define(:version => 20090425105913) do

  create_table "albums", :force => true do |t|
    t.integer  "parent_id",                  :default => 0
    t.string   "title"
    t.string   "description"
    t.boolean  "is_visible",                 :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",   :limit => 200
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :default => 0
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "geotags", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.integer  "album_id"
    t.integer  "image_id"
    t.string   "path"
    t.string   "title"
    t.string   "caption"
    t.boolean  "is_visible",                :default => true
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",  :limit => 200
    t.integer  "geotag_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "emailaddress"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
