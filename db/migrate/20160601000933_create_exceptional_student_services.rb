class CreateExceptionalStudentServices < ActiveRecord::Migration
  def change
    create_table :exceptional_student_services do |t|
      t.float :percent_special_education
      t.integer :number_special_education
      t.float :percent_504
      t.integer :number_504
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
