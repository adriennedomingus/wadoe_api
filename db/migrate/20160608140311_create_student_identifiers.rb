class CreateStudentIdentifiers < ActiveRecord::Migration
  def change
    create_table :student_identifiers do |t|
      t.string :name
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
