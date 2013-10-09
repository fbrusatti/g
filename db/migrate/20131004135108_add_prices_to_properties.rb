class AddPricesToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :prices, :string
  end
end
