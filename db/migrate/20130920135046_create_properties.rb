class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :amount_rooms
      t.string :title_to_print
      t.string :address
      t.string :description
      t.integer :amount_bathrooms
      t.integer :lot
      t.integer :meters_constructed
      t.decimal :price, precision: 8, scale: 2
      t.string :influence_zone
      t.string :type_property
      t.string :position
      t.string :type_transaction

      t.timestamps
    end
    add_index :properties, :type_transaction
    add_index :properties, :type_property
  end
end
