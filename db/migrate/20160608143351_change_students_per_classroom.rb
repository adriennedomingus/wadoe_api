class ChangeStudentsPerClassroom < ActiveRecord::Migration
  def change
    rename_column :student_enrollments, :students_per_classroom, :students_per_classroom_teacher
  end
end
