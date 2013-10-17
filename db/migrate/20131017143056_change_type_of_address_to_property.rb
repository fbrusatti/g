class ChangeTypeOfAddressToProperty < ActiveRecord::Migration
  def up
    change_column :properties, :address, :text
  end
  def down
    change_column :properties, :address, :string
  end
end
