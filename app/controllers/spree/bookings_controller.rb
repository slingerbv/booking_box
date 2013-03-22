class Spree::BookingsController < Spree::OrdersController
  helper 'spree/base'
  before_filter :state_city ,:only=>[:new , :create]

  def new
    if !current_user.nil? && !current_user.blank?
      @booking = Spree::Booking.new({:pickup_address_postal_code => current_user.postal_code,:pickup_address_city=>current_user.place,:pickup_address_country=>current_user.country,:street=>current_user.street,:house_number=>current_user.house_number})
    else
      @booking = Spree::Booking.new
    end  


    respond_to do |format|
        format.html 
        format.js
    end
  end

  def show
    @booking = Spree::Booking.find_by_id(params[:id])
  end

  # def create  
  #   @booking = Spree::Booking.new(params[:booking])
  #   if @booking.save
  #       @array_of_products_and_qty = @booking.find_duration
  #       @array_of_products_and_qty.each do |product|
  #           populator = Spree::OrderPopulator.new(current_order(true), current_currency)    
  #           add_to_cart_params = {:variants =>{product[:product].master.id.to_s=>product[:quantity].to_i}}
  #           if populator.populate(add_to_cart_params)
  #             fire_event('spree.cart.add')
  #             fire_event('spree.order.contents_changed')              
  #           end
  #       end 
  #       #render :new 
  #      respond_with(@order) do |format|
  #       format.html { redirect_to cart_path }
  #       format.js
  #      end      
  #   else
  #       render :new 
  #   end
  # end

  def create
    @booking = Spree::Booking.new(params[:booking])
    @booking.rating = session[:booking_rating]
    @booking.pickup_date = session[:booking_pickup_date]
    @booking.box_pickup_time = session[:box_pickup_time]
    respond_to do |format|
      if @booking.save
        format.html { redirect_to(booking_product_booking_path(@booking)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def index
    redirect_to(new_booking_url) unless params[:booking]
  end

  def find_pickup_city
     @booking_cities = BookingCity.where(:booking_country_id=>params[:booking_country_id])
     respond_to do |format|
     format.js
     end 
  end 

  def find_delivery_city
    @booking_cities = BookingCity.where(:booking_country_id=>params[:booking_country_id])
    respond_to do |format|
     format.js
    end
  end

  def booking_product
    # @booking = Spree::Booking.find(params[:id])
    # @diff_of_days = (@booking.delivery_date.to_date - @booking.pickup_date.to_date).to_i
    # @all_number_of_days = Spree::Product.all.map(&:number_of_days).compact.sort
    # until @diff_of_days == 0  do
    #   index_count = 0
    #   product_array = Array.new
    #   @all_number_of_days.each_with_index do |number_of_day,index|
    #     index_count = index
    #     if (number_of_day > @diff_of_days)
    #       break
    #     end  
    #   end 
    #   product = Hash.new
    #   product[:product] = @all_number_of_days[index_count - 1]
    #   product[:qty] = @diff_of_days / @all_number_of_days[index_count - 1]
    #   product_array << product
    #   @diff_of_days = @diff_of_days % @all_number_of_days[index_count - 1]
    # end
    respond_to do |format|
     format.html
    end
  end 

  def additional_services
    @booking = Spree::Booking.new
  end 

  def post_additional_services
  
    @booking = Spree::Booking.find(params[:id])
    respond_to do |format|
      if @booking.update_attributes(params[:booking])
        if params[:last_step] == ""
          begin
            ActionMailer::Base::UserMailer.booking_creation_email(@booking,@current_user).deliver 
          rescue
            puts "there is some error"
          end 
        end
        format.html { redirect_to(booking_payment_booking_path, :notice => 'Email was successfully updated.') }
      else
        format.html { render :action => "additional_services" }
      end
    end
  end  

  def booking_payment
    @booking = Spree::Booking.new
    @booking_photo = Spree::Booking.find(params[:id])
  end  



  protected

  def state_city
    @booking_countries = BookingCountry.all
    @booking_postal_codes = BookingPostalCode.all
    @default_country = BookingCountry.find_by_name("Germany")
    @booking_city = BookingCity.where(:booking_country_id=>@default_country.id)
  end


end