# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_07_140413) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badges", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.time "duration"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_badges_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "date_heure_reservation"
    t.datetime "date_heure_debut_recharge"
    t.datetime "date_heure_fin_recharge"
    t.string "status"
    t.bigint "vehicle_id", null: false
    t.bigint "station_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "duree_recharge"
    t.index ["station_id"], name: "index_bookings_on_station_id"
    t.index ["vehicle_id"], name: "index_bookings_on_vehicle_id"
  end

  create_table "conflicts", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "resolution"
    t.bigint "booking_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_conflicts_on_booking_id"
    t.index ["user_id"], name: "index_conflicts_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_messages_on_booking_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "address"
    t.string "plug"
    t.string "brand"
    t.string "model"
    t.float "parking_price"
    t.float "consomation_price"
    t.integer "max_kW_recharge"
    t.boolean "available"
    t.date "avaibility_end"
    t.integer "code_station"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_stations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.integer "xp"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "immatriculation"
    t.string "plug"
    t.integer "max_kW_recharge"
    t.integer "model_year"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "badges", "users"
  add_foreign_key "bookings", "stations"
  add_foreign_key "bookings", "vehicles"
  add_foreign_key "conflicts", "bookings"
  add_foreign_key "conflicts", "users"
  add_foreign_key "messages", "bookings"
  add_foreign_key "messages", "users"
  add_foreign_key "stations", "users"
  add_foreign_key "vehicles", "users"
end
