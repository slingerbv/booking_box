Spree::Core::Engine.routes.append do
  resources :bookings do 
  	collection do 
  	 	get "find_pickup_city"
      get "find_delivery_city"
  	end
    member do
      get "booking_product"
      get "additional_services"
      get "booking_payment"
      post "post_additional_services"
    end
  end
  namespace :admin do
    resources :bookings do
    	collection do
    		get 'next_month_bookings'
    		match "export_xls" => "bookings#export_xls"
    	end
    end
  end


end
