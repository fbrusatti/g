class AddIntegerPricesToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :to_sale, :decimal, precision: 10, scale: 2
    add_column :properties, :to_rent, :decimal, precision: 10, scale: 2
  end
end
