class CreateFiveYearGraduationRates < ActiveRecord::Migration
  def change
    create_table :five_year_graduation_rates do |t|
      t.references :district, index: true, foreign_key: true
      t.references :school_year, index: true, foreign_key: true
      t.references :student_identifier, index: true, foreign_key: true
      t.references :dropout, index: true, foreign_key: true
      t.integer :began_in_wa
      t.integer :transferred_into_wa
      t.integer :transferred_out
      t.integer :adjusted_cohort
      t.integer :graduates
      t.integer :continuing
      t.float :adjusted_five_year_cohort_graduation_percent
      t.float :cohort_dropout_percent
      t.float :continuing_percent

      t.timestamps null: false
    end
  end
end
