class AddRefNumberPhotosToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :old_reference, :string
  end
end
