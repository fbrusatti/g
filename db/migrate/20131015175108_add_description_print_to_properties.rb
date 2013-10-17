class AddDescriptionPrintToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :description_to_print, :text
  end
end
