class AddSlugToEducationalServiceDistrict < ActiveRecord::Migration
  def change
    add_column :educational_service_districts, :slug, :string
  end
end
