class RenameBookingsSpreeBookings < ActiveRecord::Migration
  def up
  	rename_table :bookings, :spree_bookings
  end

  def down
  	rename_table :bookings, :spree_bookings
  end
end
