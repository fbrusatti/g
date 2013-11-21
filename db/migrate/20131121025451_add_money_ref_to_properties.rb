class AddMoneyRefToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :m_to_rent_id, :integer
    add_column :properties, :m_to_sale_id, :integer
  end
end
