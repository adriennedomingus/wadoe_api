class CreateOtherDemographics < ActiveRecord::Migration
  def change
    create_table :other_demographics do |t|
      t.float :percent_migrant
      t.integer :number_migrant
      t.float :percent_transitional
      t.integer :number_transitional
      t.float :percent_frl
      t.integer :number_frl
      t.float :percent_foster_care
      t.integer :number_foster_care
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
