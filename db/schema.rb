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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131013223542) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "surname"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "appointments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "property_id"
    t.integer  "customer_id"
    t.string   "title"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "model"
    t.string   "status"
    t.integer  "priority"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "dni"
    t.string   "phones"
    t.string   "address"
    t.date     "dob"
    t.string   "email"
    t.string   "profession"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "customers", ["dni"], :name => "index_customers_on_dni"
  add_index "customers", ["name"], :name => "index_customers_on_name"
  add_index "customers", ["surname"], :name => "index_customers_on_surname"
  add_index "customers", ["user_id"], :name => "index_customers_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "countri"
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "money", :force => true do |t|
    t.string   "name"
    t.string   "symbol",                                   :default => "$"
    t.decimal  "quotation",  :precision => 8, :scale => 2
    t.integer  "p_rent_id"
    t.integer  "p_sale_id"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image"
    t.integer  "property_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "photos", ["image"], :name => "index_photos_on_image"

  create_table "properties", :force => true do |t|
    t.integer  "amount_rooms"
    t.string   "title_to_print"
    t.string   "address"
    t.string   "description"
    t.integer  "amount_bathrooms"
    t.integer  "lot"
    t.integer  "meters_constructed"
    t.string   "influence_zone"
    t.string   "type_property"
    t.string   "position"
    t.string   "type_transaction"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "user_id"
    t.string   "key_possessor"
    t.string   "status",             :default => ""
    t.integer  "owner_id"
    t.string   "prices"
  end

  add_index "properties", ["key_possessor"], :name => "index_properties_on_key_possessor"
  add_index "properties", ["owner_id"], :name => "index_properties_on_owner_id"
  add_index "properties", ["status"], :name => "index_properties_on_status"
  add_index "properties", ["type_property"], :name => "index_properties_on_type_property"
  add_index "properties", ["type_transaction"], :name => "index_properties_on_type_transaction"
  add_index "properties", ["user_id"], :name => "index_properties_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",             :null => false
    t.string   "encrypted_password",     :default => "",             :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,              :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
    t.string   "surname",                :default => "Surname User", :null => false
    t.string   "name",                   :default => "Name User",    :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["surname"], :name => "index_users_on_surname"

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
