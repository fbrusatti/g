class AddRemoveToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :active, :boolean, default: true
  end
end
