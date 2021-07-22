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

ActiveRecord::Schema.define(version: 20190116093762) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "bank_name"
    t.bigint "bsb"
    t.string "account_number"
    t.string "account_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "bill_companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
  end

  create_table "bill_payments", force: :cascade do |t|
    t.string "account_no"
    t.string "utility_type"
    t.string "company_name"
    t.decimal "bill_amount", precision: 10, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.integer "utility_type_id"
    t.integer "bill_company_id"
    t.index ["bill_company_id"], name: "index_bill_payments_on_bill_company_id"
    t.index ["user_id"], name: "index_bill_payments_on_user_id"
    t.index ["utility_type_id"], name: "index_bill_payments_on_utility_type_id"
  end

  create_table "bill_reminders", force: :cascade do |t|
    t.string "title"
    t.integer "all_day"
    t.integer "start_date"
    t.integer "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
    t.index ["user_id"], name: "index_bill_reminders_on_user_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "user_id"
    t.string "full_name"
    t.string "email"
    t.string "website"
    t.string "phone_number"
    t.string "gender"
    t.datetime "dob"
    t.string "address"
    t.string "interests"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "forgot_passwords", force: :cascade do |t|
    t.string "token"
    t.datetime "expiry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_forgot_passwords_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "amount"
    t.string "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_games_on_game_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "manual_processings", force: :cascade do |t|
    t.string "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "process_by"
    t.boolean "processed", default: false
    t.index ["receipt_id"], name: "index_manual_processings_on_receipt_id"
  end

  create_table "receipt_items", force: :cascade do |t|
    t.integer "receipt_id"
    t.string "item_name"
    t.integer "quantity"
    t.string "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "receipt_partial_id"
    t.index ["receipt_id"], name: "index_receipt_items_on_receipt_id"
    t.index ["receipt_partial_id"], name: "index_receipt_items_on_receipt_partial_id"
  end

  create_table "receipt_partials", force: :cascade do |t|
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "receipt_id"
    t.string "name"
    t.datetime "receipt_date"
    t.integer "user_id"
    t.string "address"
    t.string "total_paid"
    t.integer "status"
    t.integer "manual_entry_by"
    t.boolean "is_deleted", default: false
    t.datetime "deleted_at"
    t.index ["manual_entry_by"], name: "index_receipt_partials_on_manual_entry_by"
    t.index ["receipt_id"], name: "index_receipt_partials_on_receipt_id"
    t.index ["user_id"], name: "index_receipt_partials_on_user_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "name"
    t.datetime "receipt_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.string "total_paid"
    t.string "picture_file_name"
    t.string "picture_content_type"
    t.integer "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer "status"
    t.integer "manual_entry_by"
    t.boolean "is_deleted", default: false
    t.datetime "deleted_at"
    t.integer "mivi_credit", default: 0
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "reward_services", force: :cascade do |t|
    t.bigint "game_token", default: 0
    t.integer "credit_money", default: 0
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reward_services_on_user_id"
  end

  create_table "topups", force: :cascade do |t|
    t.decimal "amount"
    t.string "method"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_id"
    t.integer "user_id"
    t.index ["user_id"], name: "index_topups_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer "user_id"
    t.string "transfer_to"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transfers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.string "mobile_number"
    t.string "token"
    t.string "password"
    t.string "gender"
    t.datetime "dob"
    t.string "address"
  end

  create_table "utility_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_deleted", default: false
  end

  create_table "withdraws", force: :cascade do |t|
    t.integer "account_to"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["account_to"], name: "index_withdraws_on_account_to"
    t.index ["user_id"], name: "index_withdraws_on_user_id"
  end

end
