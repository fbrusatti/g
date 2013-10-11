class RemovePriceFromProperties < ActiveRecord::Migration
  def up
    remove_column :properties, :price
  end

  def down
    add_column :properties, :price, :decimal, precision: 8, scale: 2
  end
end
