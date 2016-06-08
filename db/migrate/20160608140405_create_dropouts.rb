class CreateDropouts < ActiveRecord::Migration
  def change
    create_table :dropouts do |t|
      t.integer :year_1
      t.integer :year_2
      t.integer :year_3
      t.integer :year_4
      t.integer :year_5

      t.timestamps null: false
    end
  end
end
