class AddUserIdToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :owner_id, :integer
  end
end
