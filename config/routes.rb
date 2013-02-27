Spree::Core::Engine.routes.append do
  resources :bookings

  namespace :admin do
    resources :bookings do
    	collection do
    		get 'next_month_bookings'
    		match "export_xls" => "bookings#export_xls"
    	end
    end
  end


end
