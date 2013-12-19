class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.references :property
      t.references :customer
      t.timestamps
    end
  end
end
