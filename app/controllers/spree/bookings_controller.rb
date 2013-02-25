class Spree::BookingsController < Spree::OrdersController
	helper 'spree/base'

	def new
		@booking = Spree::Booking.new({:pickup_address => params[:post_code],:volume=>params[:volume],:pickup_date=>params[:pick_date],
      :delivery_address =>params[:dest_code],:delivery_date=>params[:del_date]})
	end

	def show
    @booking = Spree::Booking.find_by_id(params[:id])
  end

  def create
    @booking = Spree::Booking.new(params[:booking])
    if @booking.save
      debugger
     ActionMailer::Base::UserMailer.delay({ :run_at => 2.minutes.from_now}).welcome_email(@booking) 

     
     ActionMailer::Base::BookingMailer(booking_confirm).deliver
        @array_of_products_and_qty = @booking.find_duration
        @array_of_products_and_qty.each do |product|
            populator = Spree::OrderPopulator.new(current_order(true), current_currency)    
            add_to_cart_params = {:variants =>{product[:product].master.id.to_s=>product[:quantity].to_i}}
            if populator.populate(add_to_cart_params)
              fire_event('spree.cart.add')
              fire_event('spree.order.contents_changed')              
            end
        end 
        #render :new 
       respond_with(@order) do |format|
        format.html { redirect_to cart_path }
       end      

    else
        render :new 
    end
  end

  def index
    redirect_to(new_booking_url) unless params[:booking]
  end


end
