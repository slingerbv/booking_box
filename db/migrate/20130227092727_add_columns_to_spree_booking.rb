class AddColumnsToSpreeBooking < ActiveRecord::Migration
  def change
  	add_column :spree_bookings,:pickup_address_streetname_and_number,:string
  	add_column :spree_bookings,:pickup_address_postal_code,:string
  	add_column :spree_bookings,:pickup_address_city,:string
  	add_column :spree_bookings,:pickup_address_country,:string
  	add_column :spree_bookings,:delivery_address_streetname_and_number,:string
  	add_column :spree_bookings,:delivery_address_postal_code,:string
  	add_column :spree_bookings,:delivery_address_city,:string
  	add_column :spree_bookings,:delivery_address_country,:string
  end
end
