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

ActiveRecord::Schema.define(version: 2018_10_29_093935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "beneficiaries", force: :cascade do |t|
    t.string "full_name"
    t.string "address"
    t.integer "city_id"
    t.string "telephone"
    t.integer "family_size"
    t.integer "children_count"
    t.integer "max_shop_count"
    t.integer "current_shop_count"
    t.integer "frequency"
    t.integer "provider_id"
    t.decimal "contribution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: false
    t.integer "proposed_max_shop_count"
    t.index ["city_id"], name: "index_beneficiaries_on_city_id"
    t.index ["frequency"], name: "index_beneficiaries_on_frequency"
    t.index ["is_active"], name: "index_beneficiaries_on_is_active"
    t.index ["provider_id"], name: "index_beneficiaries_on_provider_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_providers_on_user_id"
  end

  create_table "shopping_items", force: :cascade do |t|
    t.integer "shopping_id"
    t.integer "warehouse_item_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopping_id"], name: "index_shopping_items_on_shopping_id"
    t.index ["warehouse_item_id"], name: "index_shopping_items_on_warehouse_item_id"
  end

  create_table "shoppings", force: :cascade do |t|
    t.string "code"
    t.integer "beneficiary_id"
    t.integer "provider_id"
    t.decimal "total"
    t.text "items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiary_id"], name: "index_shoppings_on_beneficiary_id"
    t.index ["code"], name: "index_shoppings_on_code"
    t.index ["provider_id"], name: "index_shoppings_on_provider_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "full_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.integer "app_role", default: 0
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "warehouse_items", force: :cascade do |t|
    t.string "code"
    t.text "description"
    t.integer "item_category_id"
    t.decimal "price"
    t.integer "stock_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_warehouse_items_on_code"
    t.index ["item_category_id"], name: "index_warehouse_items_on_item_category_id"
  end

end
