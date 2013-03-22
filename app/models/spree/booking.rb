class Spree::Booking < ActiveRecord::Base
   attr_accessible :name,:pickup_date,:delivery_date,:pickup_address,:delivery_address,:volume,:phone_number,:email,:parking_zone,:length_rental,:recurring,:rating,:pickup_address_streetname_and_number,:pickup_address_postal_code,:pickup_address_city,:pickup_address_country,:delivery_address_streetname_and_number,:delivery_address_postal_code,:delivery_address_city,:delivery_address_country,:booking_type,:parking_place,:comment,:packaging,:photo,:street,:house_number,:box_delivery_time
   #validates :name,:pickup_date,:delivery_date,:email,:phone_number,:pickup_address_streetname_and_number,:delivery_address_streetname_and_number,:length_rental, :presence => true
   #validates_format_of :email, :with => /^.+@.+$/
   #after_create :notify_booking
   #validates :photo
   has_attached_file :photo,:styles => {
      :thumb=> "100x100#",
      :small  => "150x150>" }  

    def self.search(search)
    if search
      where(:pickup_date => (search["start_date"].to_date)..(search["end_date"].to_date))
    else
      scoped
    end
  end


  def find_duration
    order_porducts = []
    time_diff_components = Time.diff(Time.parse(self.delivery_date.to_s), Time.parse(self.pickup_date.to_s))
    if time_diff_components[:month]  > 0
        case time_diff_components[:month]
          when 1..2 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 Monat"),:quantity=>time_diff_components[:month]} )
          when 3 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("3 Monat"),:quantity=>1} )
          when 4..5 then
              order_porducts.push( {:product=> Spree::Product.find_by_name("3 Monat"),:quantity=>1} )
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 Monat"),:quantity=>(time_diff_components[:month]-3)} )
          when 6 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("6 Monat"),:quantity=>1} )
          when 7..time_diff_components[:month] then 
            order_porducts.push( {:product=> Spree::Product.find_by_name("6 Monat"),:quantity=>1} )
            order_porducts.push( {:product=> Spree::Product.find_by_name("1 Monat"),:quantity=>(time_diff_components[:month]-6)} )
        end
      end  
    if time_diff_components[:year] > 0   
        case time_diff_components[:year]
          when 1 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 Year"),:quantity=>1} )
          when 2 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("2 Year"),:quantity=>1} )    
          when 3..time_diff_components[:year] then     
            order_porducts.push( {:product=> Spree::Product.find_by_name("2 Year"),:quantity=>1} )
            order_porducts.push( {:product=> Spree::Product.find_by_name("1 Year"),:quantity=>time_diff_components[:year]-2} )
        end 
    end    
    if time_diff_components[:week] > 0   
        case time_diff_components[:week]
          when 1 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 week"),:quantity=>1} )
        end     
    end  

    if time_diff_components[:day] > 0   
        case time_diff_components[:day]
          when 1 then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 day"),:quantity=>1} )
          when 1..time_diff_components[:day] then 
              order_porducts.push( {:product=> Spree::Product.find_by_name("1 day"),:quantity=>time_diff_components[:day]} )    
        end     
    end  
    order_porducts
  end

 def parking_permit
    OrderSetting.first.parking_permit
  end

  # def notify_booking
  #   debugger
  #   ActionMailer::Base::UserMailer.booking_creation_email.deliver
  #    #ActionMailer::Base::UserMailer.delay({ :run_at => 2.minutes.from_now}).welcome_email(@booking) 
  # end



  # def notify_admin
  #   admin_role
  #   @users.each do |user|
  #     UserMailer.article_creation_email(self,user).deliver
  #   end
  # end

end
