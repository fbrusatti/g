class AddStatusToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :status, :integer, default: 1
    add_index :properties, :status
  end
end
