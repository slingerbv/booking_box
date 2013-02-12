class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :pick_date
      t.string :del_date
      t.string :addr
      t.string :dest
      t.string :vol
      t.string :ph_no
      t.string :email
      t.string :name
      t.boolean :park_zone
      t.string :length_rental

      t.timestamps
    end
  end
end
