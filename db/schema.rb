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

ActiveRecord::Schema[7.0].define(version: 2022_11_14_184505) do
  create_table "addresses", force: :cascade do |t|
    t.string "alias"
    t.text "stracTokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zipCode"
  end

  create_table "personal_identities", force: :cascade do |t|
    t.string "name"
    t.string "ssn"
    t.text "stracTokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
