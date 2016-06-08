class CreateStudentEnrollments < ActiveRecord::Migration
  def change
    create_table :student_enrollments do |t|
      t.integer :total
      t.integer :students_per_classroom

      t.timestamps null: false
    end
  end
end
