class CreateRaceEthnicities < ActiveRecord::Migration
  def change
    create_table :race_ethnicities do |t|
      t.float :percent_american_indian
      t.integer :number_american_indian
      t.float :percent_asian
      t.integer :number_asian
      t.float :percent_pacific_islander
      t.integer :number_pacific_islander
      t.float :percent_asian_pacific_islander
      t.integer :number_asian_pacific_islander
      t.float :percent_black
      t.integer :number_black
      t.float :percent_hispanic
      t.integer :number_hispanic
      t.float :percent_white
      t.integer :number_white
      t.float :percent_two_or_more
      t.integer :number_two_or_more
      t.references :student_enrollment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
