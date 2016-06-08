class CreateSchoolYears < ActiveRecord::Migration
  def change
    create_table :school_years do |t|
      t.string :years

      t.timestamps null: false
    end
  end
end
