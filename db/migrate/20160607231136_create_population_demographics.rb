class CreatePopulationDemographics < ActiveRecord::Migration
  def change
    create_table :population_demographics do |t|
      t.integer :number
      t.float :percent
      t.references :student_identifier, index: true, foreign_key: true
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
