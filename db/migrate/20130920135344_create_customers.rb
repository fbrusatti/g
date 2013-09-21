class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.string :dni
      t.string :phones
      t.string :address
      t.date   :dob
      t.string :email
      t.string :profession
      t.timestamps
    end
    add_index :customers, :name
    add_index :customers, :surname
    add_index :customers, :dni
  end
end
