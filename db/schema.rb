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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160608143351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "district_school_years", force: :cascade do |t|
    t.integer  "school_year_id"
    t.integer  "district_id"
    t.integer  "student_enrollment_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "district_school_years", ["district_id"], name: "index_district_school_years_on_district_id", using: :btree
  add_index "district_school_years", ["school_year_id"], name: "index_district_school_years_on_school_year_id", using: :btree
  add_index "district_school_years", ["student_enrollment_id"], name: "index_district_school_years_on_student_enrollment_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.integer  "educational_service_district_id"
    t.integer  "county_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "slug"
  end

  add_index "districts", ["county_id"], name: "index_districts_on_county_id", using: :btree
  add_index "districts", ["educational_service_district_id"], name: "index_districts_on_educational_service_district_id", using: :btree

  create_table "dropouts", force: :cascade do |t|
    t.integer  "year_1"
    t.integer  "year_2"
    t.integer  "year_3"
    t.integer  "year_4"
    t.integer  "year_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "educational_service_districts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "five_year_graduation_rates", force: :cascade do |t|
    t.integer  "district_school_year_id"
    t.integer  "student_identifier_id"
    t.integer  "dropout_id"
    t.integer  "began_9_in_wa"
    t.integer  "transferred_in"
    t.integer  "transferred_out"
    t.integer  "adjusted_cohort"
    t.integer  "graduates"
    t.integer  "continuing"
    t.float    "adjusted_five_year_cohort_graduation_rate"
    t.float    "cohort_dropout_rate"
    t.float    "continuing_rate"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "five_year_graduation_rates", ["district_school_year_id"], name: "index_five_year_graduation_rates_on_district_school_year_id", using: :btree
  add_index "five_year_graduation_rates", ["dropout_id"], name: "index_five_year_graduation_rates_on_dropout_id", using: :btree
  add_index "five_year_graduation_rates", ["student_identifier_id"], name: "index_five_year_graduation_rates_on_student_identifier_id", using: :btree

  create_table "population_demographics", force: :cascade do |t|
    t.integer  "number"
    t.float    "percent"
    t.integer  "district_school_year_id"
    t.integer  "student_identifier_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "population_demographics", ["district_school_year_id"], name: "index_population_demographics_on_district_school_year_id", using: :btree
  add_index "population_demographics", ["student_identifier_id"], name: "index_population_demographics_on_student_identifier_id", using: :btree

  create_table "school_years", force: :cascade do |t|
    t.string   "years"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_enrollments", force: :cascade do |t|
    t.integer  "total"
    t.integer  "students_per_classroom_teacher"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "student_identifiers", force: :cascade do |t|
    t.string   "name"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "student_identifiers", ["tag_id"], name: "index_student_identifiers_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "api_key"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "district_school_years", "districts"
  add_foreign_key "district_school_years", "school_years"
  add_foreign_key "district_school_years", "student_enrollments"
  add_foreign_key "districts", "counties"
  add_foreign_key "districts", "educational_service_districts"
  add_foreign_key "five_year_graduation_rates", "district_school_years"
  add_foreign_key "five_year_graduation_rates", "dropouts"
  add_foreign_key "five_year_graduation_rates", "student_identifiers"
  add_foreign_key "population_demographics", "district_school_years"
  add_foreign_key "population_demographics", "student_identifiers"
  add_foreign_key "student_identifiers", "tags"
end
