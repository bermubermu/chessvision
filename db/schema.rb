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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110607155851) do

  create_table "alloweds", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_club"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "answers", :force => true do |t|
    t.string   "reply",       :limit => 2040
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_problem"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "battles", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "round"
    t.float    "result"
    t.integer  "id_tournament"
    t.string   "id_usuario1"
    t.integer  "id_usuario2"
    t.string   "id_usuario3"
    t.integer  "id_usuario4"
  end

  create_table "books", :force => true do |t|
    t.string   "event"
    t.string   "site"
    t.integer  "round"
    t.string   "white"
    t.string   "black"
    t.string   "elo_white"
    t.string   "elo_black"
    t.string   "eco"
    t.string   "date"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_usuario"
    t.string   "attachment"
    t.string   "description"
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "province"
    t.string   "person"
    t.string   "phone"
    t.string   "date"
    t.string   "information"
    t.integer  "id_usuario"
  end

  create_table "microposts", :force => true do |t|
    t.string   "coment",      :limit => 2040
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_book"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "notices", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coment",      :limit => 2040
    t.integer  "id_club"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "players", :force => true do |t|
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_tournament"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
    t.integer  "control"
    t.integer  "control2"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coment",      :limit => 2040
    t.integer  "id_club"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "problems", :force => true do |t|
    t.string   "name"
    t.string   "question"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_usuario"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
  end

  create_table "requests", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coment",      :limit => 2040
    t.integer  "id_club"
    t.string   "id_usuario"
    t.integer  "id_usuario2"
  end

  create_table "sites", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment"
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_players"
    t.integer  "number_rounds"
    t.string   "country"
    t.string   "city"
    t.string   "organizador"
    t.string   "email"
    t.string   "url"
    t.string   "information"
    t.string   "visible"
    t.integer  "id_usuario"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "phone"
    t.integer  "elo",                :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
