class ChangeTypeOfDescriptionToProperties < ActiveRecord::Migration
  def up
    change_column :properties, :description, :text
  end
  def down
    change_column :properties, :description, :string
  end
end
