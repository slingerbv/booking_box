class Spree::Admin::BookingsController < Spree::Admin::BaseController



    def index
     @bookings = Spree::Booking.all
     if !params[:search].blank? 
        if !params[:search]["start_date"].blank? && !params[:search]["end_date"].blank?
          @bookings =  Spree::Booking.search(params[:search]) 
        else
          @bookings = []
        end  
     end        

    respond_to do |format|
      format.html 
      format.json { render json: @bookings }

    end
  end

   def export_xls
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = ''
    @next_month_bookings = Spree::Booking.where('delivery_date BETWEEN ? AND ?', Time.now.at_beginning_of_month + 1.month , Time.now.at_end_of_month + 1.month).all
    render :layout => false
  end   


  def show
    @booking = Spree::Booking.find(params[:id])
  end

  def next_month_bookings
    @next_month_bookings = Spree::Booking.where('delivery_date BETWEEN ? AND ?', Time.now.at_beginning_of_month + 1.month , Time.now.at_end_of_month + 1.month).all
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