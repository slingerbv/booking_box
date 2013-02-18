class Spree::Booking < ActiveRecord::Base
   attr_accessible :name,:pick_date,:del_date,:addr,:dest,:vol,:ph_no,:email,:park_zone,:length_rental,:recurring

   validates :name,:pick_date,:del_date,:addr,:dest,:vol,:ph_no,:email,:length_rental , :presence => true
   validates_format_of :email, :with => /^.+@.+$/

  def find_product  
    Spree::Product.find_by_name("1 Monat")
  end

  def find_duration
  	time_diff_components = Time.diff(Time.parse(self.del_date.to_s), Time.parse(self.pick_date.to_s),'%M')
      day = time_diff_components[:day] 
      month = time_diff_components[:month] 
      if time_diff_components[:day] > 0
        month = month+1
      end 
     month  
  end 	

end
