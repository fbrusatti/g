class AddOwnerRefToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :owner_id, :integer
    add_index :properties, :owner_id
  end
end
