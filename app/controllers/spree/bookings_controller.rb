class Spree::BookingsController < Spree::OrdersController
  helper 'spree/base'
  before_filter :state_city ,:only=>[:new , :create]

  def new
    @booking = Spree::Booking.new({:phone_number => current_user.phone,:email=>current_user.email,:name=>current_user.name,:rating=>session[:booking_rating]})

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
    respond_to do |format|
      if @booking.save
        begin
          ActionMailer::Base::UserMailer.booking_creation_email(@booking).deliver 
        rescue
          puts "there is some error"
        end  
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
    respond_to do |format|
     format.html
    end
  end 

  def additional_services
    @booking = Spree::Booking.new
  end 

  def post_additional_services
    puts "d"
  end  

  def booking_payment
  end  

  protected

  def state_city
    @booking_countries = BookingCountry.all
    @booking_postal_codes = BookingPostalCode.all
    @default_country = BookingCountry.find_by_name("Germany")
    @booking_city = BookingCity.where(:booking_country_id=>@default_country.id)
  end


end