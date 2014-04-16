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

ActiveRecord::Schema.define(:version => 20140325180623) do

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

  create_table "commodities", :force => true do |t|
    t.integer  "commodity_group_id"
    t.string   "name"
    t.integer  "priority"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "commodities", ["commodity_group_id"], :name => "index_commodities_on_commodity_group_id"

  create_table "commodities_farms", :force => true do |t|
    t.integer "commodity_id"
    t.integer "farm_id"
  end

  create_table "commodity_groups", :force => true do |t|
    t.string   "name"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "faqs", :force => true do |t|
    t.string   "question"
    t.string   "answer"
    t.string   "locale"
    t.boolean  "enabled"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "file"
    t.string   "description"
    t.integer  "place_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ownerships", :force => true do |t|
    t.integer "place_id"
    t.integer "user_id"
    t.boolean "contact_by_email", :default => false
    t.boolean "contact_by_phone", :default => false
  end

  add_index "ownerships", ["place_id", "user_id"], :name => "index_ownerships_on_place_id_and_user_id"

  create_table "place_connections", :force => true do |t|
    t.integer "place_a_id", :null => false
    t.integer "place_b_id", :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.decimal  "latitude",                       :precision => 15, :scale => 10
    t.decimal  "longitude",                      :precision => 15, :scale => 10
    t.string   "accepts_new_members",                                            :default => "yes"
    t.boolean  "is_established",                                                 :default => true
    t.text     "description"
    t.integer  "maximum_members"
    t.text     "vegetable_products"
    t.text     "participation"
    t.string   "type"
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
    t.string   "contact_function"
    t.string   "url"
    t.integer  "founded_at_year"
    t.integer  "founded_at_month"
    t.boolean  "acts_ecological",                                                :default => false
    t.string   "economical_behavior"
    t.string   "animal_products"
    t.string   "beverages"
    t.text     "additional_product_information"
    t.text     "delivery_days"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "text_blocks", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.string   "body_format"
    t.string   "locale"
    t.boolean  "public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "translations", :force => true do |t|
    t.string   "title"
    t.string   "locale"
    t.integer  "translatable_id"
    t.string   "translatable_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "translations", ["translatable_id"], :name => "index_translations_on_translatable_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "authentication_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "phone"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
