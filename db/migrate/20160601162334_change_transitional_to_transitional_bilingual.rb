class ChangeTransitionalToTransitionalBilingual < ActiveRecord::Migration
  def change
    rename_column :other_demographics, :percent_transitional, :percent_transitional_bilingual
    rename_column :other_demographics, :number_transitional, :number_transitional_bilingual
  end
end
