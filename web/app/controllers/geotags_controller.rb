class GeotagsController < ApplicationController
  
  before_filter :login_required, :only => ["new"]
  
  def new
    @title = "Create Geotag Location"
    # Post Request
    if request.post?
      # Create a new user
      @geotag = Geotag.new(params[:geotag])
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
  
  def show
    @geotag = Geotag.find_by_id(params[:id])
    if @geotag != nil
      @title = "Showing Geotag Location - " + @geotag.description
      @map = GMap.new("map_div")
      @map.control_init(:large_map => true,:map_type => true)
      @map.set_map_type_init(GMapType::G_HYBRID_MAP);
      @map.center_zoom_init([@geotag.latitude,@geotag.longitude],@geotag.zoom)
      @map.overlay_init(GMarker.new([@geotag.latitude,@geotag.longitude], :title => "Geotag Location", :info_window => @geotag.description))
    else
      redirect_to :action => "list"
    end
    
  end
  
end
