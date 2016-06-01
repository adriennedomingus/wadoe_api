class AmericanIndianOrAlaskanNative < ActiveRecord::Migration
  def change
    rename_column :race_ethnicities, :number_american_indian, :number_american_indian_or_alaskan_native
    rename_column :race_ethnicities, :percent_american_indian, :percent_american_indian_or_alaskan_native
  end
end
