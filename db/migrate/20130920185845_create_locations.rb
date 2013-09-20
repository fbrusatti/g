class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :countri
      t.string :state

      t.timestamps
    end
  end
end