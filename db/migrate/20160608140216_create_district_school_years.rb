class CreateDistrictSchoolYears < ActiveRecord::Migration
  def change
    create_table :district_school_years do |t|
      t.references :school_year, index: true, foreign_key: true
      t.references :district, index: true, foreign_key: true
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
