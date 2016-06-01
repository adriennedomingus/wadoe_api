class CreateEducationalServiceDistricts < ActiveRecord::Migration
  def change
    create_table :educational_service_districts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
