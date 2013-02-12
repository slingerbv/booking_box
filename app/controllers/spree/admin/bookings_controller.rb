class Spree::Admin::BookingsController < Spree::Admin::ResourceController

  #resource_controller
  #inherited_resources
  #layout 'spree/layouts/admin'

  #respond_to :html, :json

  #destroy.success.wants.js { render_js_for_destroy }

  def index
    #@inquiries = Spree::Inquiry.all
    respond_with(@collection) do |format|
      format.html
      format.json { render :json => json_data }
    end
  end

  protected

  def collection
    debugger
    return @collection if @collection.present?
    unless request.xhr?
      params[:q] ||= {}
      params[:q][:s] ||= "ascend_by_email"
      # @search = Spree::Inquiry.search(params[:q])

      #set order by to default or form result
      #@search.order ||= "ascend_by_email"

      #@collection = @search.page(params[:page]).per(Spree::Config[:orders_per_page])
      # @collection = @search.result.page(params[:page]).per(Spree::Config[:orders_per_page])

    else
      @collection = Spree::Booking.find(:all, :limit => (params[:limit] || 100))
    end
  end

end