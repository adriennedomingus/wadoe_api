class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.float :percent_male
      t.integer :number_male
      t.float :percent_female
      t.integer :number_female
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
