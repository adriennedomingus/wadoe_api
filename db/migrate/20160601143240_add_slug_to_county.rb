class AddSlugToCounty < ActiveRecord::Migration
  def change
    add_column :counties, :slug, :string
  end
end
