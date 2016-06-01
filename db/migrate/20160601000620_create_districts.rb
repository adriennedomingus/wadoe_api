class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :name
      t.string :number
      t.references :educational_service_district, index: true, foreign_key: true
      t.references :county, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
