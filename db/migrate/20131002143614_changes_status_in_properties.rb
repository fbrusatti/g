class ChangesStatusInProperties < ActiveRecord::Migration
  def up
    change_column :properties, :status, :string, default: ""
  end

  def down
    execute 'ALTER TABLE properties ALTER COLUMN status TYPE integer USING CAST(status AS INTEGER)'
  end
end
