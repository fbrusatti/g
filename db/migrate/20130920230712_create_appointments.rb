class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :user
      t.references :property
      t.references :customer
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.string :type
      t.string :status
      t.integer :priority
      t.string :description

      t.timestamps
    end
  end
end
