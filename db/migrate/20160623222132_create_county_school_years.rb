class CreateCountySchoolYears < ActiveRecord::Migration
  def change
    create_table :county_school_years do |t|
      t.references :school_year, index: true, foreign_key: true
      t.references :county, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
