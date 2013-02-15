class Spree::Booking < ActiveRecord::Base
   attr_accessible :name,:pick_date,:del_date,:addr,:dest,:vol,:ph_no,:email,:park_zone,:length_rental,:recurring

   validates :name,:pick_date,:del_date,:addr,:dest,:vol,:ph_no,:email,:length_rental , :presence => true
   validates_format_of :email, :with => /^.+@.+$/
end
