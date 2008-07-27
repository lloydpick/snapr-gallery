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

ActiveRecord::Schema.define(:version => 20080726155258) do

  create_table "albums", :force => true do |t|
    t.integer  "parent_album_id"
    t.string   "title"
    t.string   "description"
    t.integer  "position"
    t.boolean  "is_visible",                     :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink",       :limit => 200
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
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "emailaddress"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
