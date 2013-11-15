class AddLocationRefToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :location_id, :integer
  end
end
