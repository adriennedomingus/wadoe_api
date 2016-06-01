class CreateStudentEnrollments < ActiveRecord::Migration
  def change
    create_table :student_enrollments do |t|
      t.references :school_year, index: true, foreign_key: true
      t.integer :total
      t.integer :students_per_classroom
      t.references :district, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
