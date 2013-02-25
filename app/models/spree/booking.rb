class Spree::Booking < ActiveRecord::Base
   attr_accessible :name,:pickup_date,:delivery_date,:pickup_address,:delivery_address,:volume,:phone_number,:email,:parking_zone,:length_rental,:recurring

   validates :name,:pick_date,:del_date,:addr,:dest,:vol,:ph_no,:email,:length_rental , :presence => true
   validates_format_of :email, :with => /^.+@.+$/


  def find_duration
    order_porducts = []
  	time_diff_components = Time.diff(Time.parse(self.del_date.to_s), Time.parse(self.pick_date.to_s))
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
end
