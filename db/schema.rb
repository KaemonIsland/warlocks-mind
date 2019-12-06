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

ActiveRecord::Schema.define(version: 2019_12_06_013614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "armors", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "armor_class"
    t.integer "armor_class_ability"
    t.integer "armor_class_max"
    t.string "armor_class_modifier"
    t.integer "strength_requirement"
    t.boolean "stealth_disadvantage"
    t.integer "cost_amount"
    t.integer "cost_type"
    t.string "notes"
    t.integer "weight"
    t.integer "don"
    t.string "don_time"
    t.integer "doff"
    t.string "doff_time"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_armors_on_user_id"
  end

  create_table "damage_types", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_damage_types_on_slug", unique: true
    t.index ["user_id"], name: "index_damage_types_on_user_id"
  end

  create_table "gears", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "cost_amount"
    t.integer "cost_type"
    t.integer "weight"
    t.string "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_gears_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_properties_on_slug", unique: true
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weapon_damage_types", force: :cascade do |t|
    t.bigint "weapon_id"
    t.bigint "damage_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["damage_type_id"], name: "index_weapon_damage_types_on_damage_type_id"
    t.index ["weapon_id"], name: "index_weapon_damage_types_on_weapon_id"
  end

  create_table "weapon_feats", force: :cascade do |t|
    t.string "title"
    t.string "notes"
    t.bigint "weapon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weapon_id"], name: "index_weapon_feats_on_weapon_id"
  end

  create_table "weapon_properties", force: :cascade do |t|
    t.bigint "weapon_id"
    t.bigint "property_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_weapon_properties_on_property_id"
    t.index ["weapon_id"], name: "index_weapon_properties_on_weapon_id"
  end

  create_table "weapons", force: :cascade do |t|
    t.string "name"
    t.integer "category"
    t.integer "cost_amount"
    t.integer "cost_type"
    t.integer "damage_amount"
    t.integer "damage_die"
    t.integer "weight"
    t.integer "range_near"
    t.integer "range_far"
    t.integer "versatile_amount"
    t.integer "versatile_die"
    t.string "notes"
    t.integer "modifier"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weapons_on_user_id"
  end

  add_foreign_key "armors", "users"
  add_foreign_key "gears", "users"
  add_foreign_key "weapons", "users"
end
