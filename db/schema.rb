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

ActiveRecord::Schema.define(version: 2026_01_07_043632) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "booking_items", force: :cascade do |t|
    t.integer "book_id", null: false
    t.integer "property_id", null: false
    t.integer "variant_id"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_booking_items_on_book_id"
    t.index ["property_id"], name: "index_booking_items_on_property_id"
    t.index ["variant_id"], name: "index_booking_items_on_variant_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "discount"
    t.string "status"
    t.integer "total_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.text "description"
    t.string "address"
    t.string "phonenumber"
    t.date "soldate"
    t.date "completiondate"
    t.boolean "is_featured_product"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "bedroom"
    t.string "bathroom"
    t.string "gerage"
    t.string "area"
    t.string "size"
    t.string "price"
    t.boolean "swimmingpool"
    t.boolean "laundryroom"
    t.boolean "twostories"
    t.boolean "energencyexit"
    t.boolean "fireplace"
    t.boolean "jogpath"
    t.boolean "ceilings"
    t.boolean "dualsinks"
    t.string "videoone"
    t.string "videotwo"
    t.string "videothree"
    t.integer "discounts"
    t.integer "rating"
    t.string "city"
    t.string "state"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "mobilenumber"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  create_table "variants", force: :cascade do |t|
    t.integer "property_id", null: false
    t.string "size"
    t.integer "bhk"
    t.integer "floor"
    t.integer "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_variants_on_property_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["property_id"], name: "index_wishlists_on_property_id"
    t.index ["user_id", "property_id"], name: "index_wishlists_on_user_id_and_property_id", unique: true
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booking_items", "books"
  add_foreign_key "booking_items", "properties"
  add_foreign_key "booking_items", "variants"
  add_foreign_key "books", "users"
  add_foreign_key "variants", "properties"
  add_foreign_key "wishlists", "properties"
  add_foreign_key "wishlists", "users"
end
