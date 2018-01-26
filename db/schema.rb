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

ActiveRecord::Schema.define(version: 20180126210325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "charge_events", force: :cascade do |t|
    t.string "stripe_charge_id"
    t.string "event_type"
    t.string "stripe_event_id"
    t.string "failure_code"
    t.string "failure_message"
    t.integer "payment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payment_id"], name: "index_charge_events_on_payment_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "account_type"
    t.string "stripe_account_guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lease_payment_reminders", force: :cascade do |t|
    t.text "email_text"
    t.string "reminder_type", null: false
    t.integer "lease_payment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lease_payments", force: :cascade do |t|
    t.integer "unit_id", null: false
    t.integer "lease_id", null: false
    t.datetime "due_date"
    t.datetime "reminder_date"
    t.datetime "past_due_date"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "local_amount"
  end

  create_table "leases", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "payment_first_date"
    t.integer "payment_amount"
    t.integer "payment_days_until_late"
    t.integer "payment_reminder_days"
    t.integer "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_id"
    t.index ["payment_id"], name: "index_leases_on_payment_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["messageable_type", "messageable_id"], name: "index_messages_on_messageable_type_and_messageable_id"
    t.index ["unit_id"], name: "index_messages_on_unit_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount"
    t.integer "amount_refunded"
    t.integer "unit_id"
    t.integer "lease_payment_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_charge_id"
    t.string "latest_event_type"
  end

  create_table "properties", force: :cascade do |t|
    t.string "address_city", null: false
    t.string "address_line1", null: false
    t.string "address_state", null: false
    t.string "address_postal", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "property_images", force: :cascade do |t|
    t.integer "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "property_managers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.integer "company_id"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_property_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_property_managers_on_reset_password_token", unique: true
  end

  create_table "residencies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "property_id"
    t.integer "company_id"
    t.integer "unit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.index ["active"], name: "index_residencies_on_active"
    t.index ["company_id"], name: "index_residencies_on_company_id"
    t.index ["property_id"], name: "index_residencies_on_property_id"
    t.index ["unit_id"], name: "index_residencies_on_unit_id"
    t.index ["user_id"], name: "index_residencies_on_user_id"
  end

  create_table "stripe_accounts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "account_type"
    t.string "dob_month"
    t.string "dob_day"
    t.string "dob_year"
    t.string "address_city"
    t.string "address_state"
    t.string "address_line1"
    t.string "address_postal"
    t.boolean "tos", default: false
    t.string "ssn_last_4"
    t.string "business_name"
    t.string "business_tax_id"
    t.string "business_id_number"
    t.string "verification_document"
    t.string "stripe_account_guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer "property_id", null: false
    t.text "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "invite_token"
    t.integer "invited_by_id"
    t.datetime "invite_date"
    t.boolean "activated", default: false
    t.string "stripe_account_guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bank_account_guid"
    t.string "bank_account_last4"
    t.string "bank_account_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invite_token"], name: "index_users_on_invite_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messages", "units"
end
