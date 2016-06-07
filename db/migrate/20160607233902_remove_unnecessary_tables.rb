class RemoveUnnecessaryTables < ActiveRecord::Migration
  def change
    drop_table :exceptional_student_services
    drop_table :genders
    drop_table :other_demographics
    drop_table :race_ethnicities
  end
end
