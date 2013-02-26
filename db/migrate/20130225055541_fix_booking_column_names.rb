class FixBookingColumnNames < ActiveRecord::Migration
  def change
  	rename_column :spree_bookings, :del_date,:delivery_date
  	rename_column :spree_bookings, :pick_date,:pickup_date
  	rename_column :spree_bookings, :addr,:pickup_address
  	rename_column :spree_bookings, :dest,:delivery_address
  	rename_column :spree_bookings, :vol,:volume
  	rename_column :spree_bookings, :ph_no,:phone_number
  	rename_column :spree_bookings, :park_zone,:parking_zone
  end


end
