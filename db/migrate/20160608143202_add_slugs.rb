class AddSlugs < ActiveRecord::Migration
  def change
    add_column :educational_service_districts, :slug, :string
    add_column :districts, :slug, :string
    add_column :counties, :slug, :string
  end
end
