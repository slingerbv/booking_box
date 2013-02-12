Spree::Core::Engine.routes.append do
  resources :bookings

  namespace :admin do
    resources :bookings
  end


  # Add your extension routes here
end
