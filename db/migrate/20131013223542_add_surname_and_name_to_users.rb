class AddSurnameAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :surname, :string, :null => false, :default => "Surname User"
    add_index :users, :surname
    add_column :users, :name, :string, :null => false, :default => "Name User"
    add_index :users, :name
  end
end
