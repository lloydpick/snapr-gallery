class GeotagController < ApplicationController
  
  before_filter :login_required, :only => ["new"]
  
  def new
    @title = "Create Geotag Location"
    # Post Request
    if request.post?
      # Create a new user
      @geotag = Geotag.new(params[:album])
      # Does it pass all validation?
      if @geotag.save
        
        # Save successful, redirect to album page
        @log = Log.new
        @log.user = current_user
        @log.item = "geotag"
        @log.event = "add_geotag"
        @log.identifier = @geotag.id
        @log.save!
        redirect_to :action => "list"
      else
        # Show the error messages
        @geotag.valid?
      end
    end
  end
  
  def list
    @title = "Listing Geotag Locations"
    @geotags = Geotag.find(:all, :order => "description DESC")
  end
  
end
