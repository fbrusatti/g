class AddRemoveToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :active, :boolean, default: true
  end
end
