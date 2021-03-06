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

ActiveRecord::Schema.define(:version => 20171213145604) do

  create_table "balances", :force => true do |t|
    t.integer  "balance"
    t.date     "date"
    t.integer  "previous_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.decimal  "rank"
  end

  create_table "conferences", :force => true do |t|
    t.string   "call"
    t.string   "name"
    t.string   "host"
    t.date     "date"
    t.string   "applicant"
    t.text     "description"
    t.integer  "funding"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "length"
    t.string   "document_url"
    t.date     "received_on"
    t.string   "email"
    t.string   "conference_url"
    t.integer  "request"
  end

  create_table "fundings", :force => true do |t|
    t.integer  "conference_id"
    t.integer  "transaction_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "amount"
  end

  create_table "labels", :force => true do |t|
    t.integer  "amount"
    t.integer  "transaction_id"
    t.integer  "category_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "number"
    t.string   "title"
    t.string   "surname"
    t.string   "forename"
    t.text     "address"
    t.string   "email"
    t.string   "status"
    t.text     "comment",    :limit => 255
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "bulletin"
    t.string   "reciprocal"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "year"
    t.integer  "member_id"
    t.integer  "transaction_id"
    t.integer  "value"
    t.integer  "payment"
    t.date     "paid_on"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "currency"
  end

  create_table "transactions", :force => true do |t|
    t.date     "date"
    t.string   "text"
    t.integer  "amount"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "balance_id"
  end

  create_table "users", :force => true do |t|
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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
