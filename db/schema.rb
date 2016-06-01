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

ActiveRecord::Schema.define(version: 20160601165102) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counties", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

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

  create_table "educational_service_districts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  create_table "exceptional_student_services", force: :cascade do |t|
    t.float    "percent_special_education"
    t.integer  "number_special_education"
    t.float    "percent_504"
    t.integer  "number_504"
    t.integer  "student_enrollment_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "exceptional_student_services", ["student_enrollment_id"], name: "index_exceptional_student_services_on_student_enrollment_id", using: :btree

  create_table "genders", force: :cascade do |t|
    t.float    "percent_male"
    t.integer  "number_male"
    t.float    "percent_female"
    t.integer  "number_female"
    t.integer  "student_enrollment_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "genders", ["student_enrollment_id"], name: "index_genders_on_student_enrollment_id", using: :btree

  create_table "other_demographics", force: :cascade do |t|
    t.float    "percent_migrant"
    t.integer  "number_migrant"
    t.float    "percent_transitional_bilingual"
    t.integer  "number_transitional_bilingual"
    t.float    "percent_frl"
    t.integer  "number_frl"
    t.float    "percent_foster_care"
    t.integer  "number_foster_care"
    t.integer  "student_enrollment_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "other_demographics", ["student_enrollment_id"], name: "index_other_demographics_on_student_enrollment_id", using: :btree

  create_table "race_ethnicities", force: :cascade do |t|
    t.float    "percent_american_indian_or_alaskan_native"
    t.integer  "number_american_indian_or_alaskan_native"
    t.float    "percent_asian"
    t.integer  "number_asian"
    t.float    "percent_pacific_islander"
    t.integer  "number_pacific_islander"
    t.float    "percent_asian_pacific_islander"
    t.integer  "number_asian_pacific_islander"
    t.float    "percent_black"
    t.integer  "number_black"
    t.float    "percent_hispanic"
    t.integer  "number_hispanic"
    t.float    "percent_white"
    t.integer  "number_white"
    t.float    "percent_two_or_more"
    t.integer  "number_two_or_more"
    t.integer  "student_enrollment_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "race_ethnicities", ["student_enrollment_id"], name: "index_race_ethnicities_on_student_enrollment_id", using: :btree

  create_table "school_years", force: :cascade do |t|
    t.string   "years"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_enrollments", force: :cascade do |t|
    t.integer  "school_year_id"
    t.integer  "total"
    t.integer  "students_per_classroom_teacher"
    t.integer  "district_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "student_enrollments", ["district_id"], name: "index_student_enrollments_on_district_id", using: :btree
  add_index "student_enrollments", ["school_year_id"], name: "index_student_enrollments_on_school_year_id", using: :btree

  add_foreign_key "districts", "counties"
  add_foreign_key "districts", "educational_service_districts"
  add_foreign_key "exceptional_student_services", "student_enrollments"
  add_foreign_key "genders", "student_enrollments"
  add_foreign_key "other_demographics", "student_enrollments"
  add_foreign_key "race_ethnicities", "student_enrollments"
  add_foreign_key "student_enrollments", "districts"
  add_foreign_key "student_enrollments", "school_years"
end
