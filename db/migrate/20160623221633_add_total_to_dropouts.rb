class AddTotalToDropouts < ActiveRecord::Migration
  def change
    add_column :dropouts, :total, :integer
  end
end
