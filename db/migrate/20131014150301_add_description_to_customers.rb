class AddDescriptionToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :description, :text
  end
end
