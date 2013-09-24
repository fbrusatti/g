class AddKeyPossessorToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :key_possessor, :string
    add_index :properties, :key_possessor
  end
end
