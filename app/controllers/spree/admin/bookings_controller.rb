class Spree::Admin::BookingsController < Spree::Admin::BaseController



  def index
    @bookings = Spree::Booking.all

    respond_to do |format|
      format.html 
      format.json { render json: @bookings }
    end
  end

  def show
    @booking = Spree::Booking.find(params[:id])
  end

  def next_month_bookings
    @next_month_bookings = Spree::Booking.where('pickup_date BETWEEN ? AND ?', Time.now.at_beginning_of_month + 1.month , Time.now.at_end_of_month + 1.month).all
  end

def destroy
    @booking = Spree::Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to admin_bookings_url }
      format.json { head :no_content }
     end
end


end