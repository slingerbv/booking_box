class AddColumnToSpreeBookings < ActiveRecord::Migration
  def change
  	add_column :spree_bookings, :recurring, :boolean
  end
end
