// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
 

  jQuery(document).ready(function() { 

    $( "#booking_pickup_date").datetimepicker(); 
    $( "#booking_delivery_date").datetimepicker(); 


    $('#booking_pickup_address_country').change(function() {
         $.ajax({ 
          type: "GET",
          data: {booking_country_id:$(this).val()},
          url: "/bookings/find_pickup_city",
          dataType: "script"
        });
        });
     //('#booking_pickup_address_country').trigger('change')

      $('#booking_delivery_address_country').change(function() {
        $.ajax({ 
          type: "GET",
          data: {booking_country_id:$(this).val()},
          url: "/bookings/find_delivery_city",
          dataType: "script"
        });
        });
     //('#booking_delivery_address_country').trigger('change')


  });