class RenameDatabaseColumnAppointment < ActiveRecord::Migration
  def self.up
    rename_column :appointments, :type, :model
  end

  def self.down
    rename_column :appointments, :type, :model
  end
end
