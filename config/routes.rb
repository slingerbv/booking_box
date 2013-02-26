Spree::Core::Engine.routes.append do
  resources :bookings

  namespace :admin do
    resources :bookings do
    	collection do
    		get 'next_month_bookings'
    	end
    end
  end


 
end
