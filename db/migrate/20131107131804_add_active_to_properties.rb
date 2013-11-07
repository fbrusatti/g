class AddActiveToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :active, :boolean, default: true
  end
end
