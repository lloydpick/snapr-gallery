class GeotagsController < ApplicationController
  
  before_filter :login_required, :only => ["new"]
  before_filter :load_objects, :only => ["show", "edit", "update"]

  def index
    set_title("Listing Geotag Locations")
    @geotags = Geotag.find(:all, :order => "description DESC")

    respond_to do |format|
      format.html
      format.xml { render :xml => @geotags }
      format.json { render :json => @geotags }
    end
  end

  def show
    set_title("Showing Geotag Location - " + @geotag.description)
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,:map_type => true)
    @map.set_map_type_init(GMapType::G_HYBRID_MAP);
    @map.center_zoom_init([@geotag.latitude,@geotag.longitude],@geotag.zoom)
    @map.overlay_init(GMarker.new([@geotag.latitude,@geotag.longitude], :title => "Geotag Location", :info_window => @geotag.description))

    respond_to do |format|
      format.html
      format.xml { render :xml => @geotag }
      format.json { render :json => @geotag }
    end
  end
  
  def new
    set_title("Create Geotag Location")
    @geotag = Geotag.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @geotag = Geotag.new(params[:geotag])

    if @geotag.save
      redirect_to geotag_path(@geotag)
    else
      @geotag.valid?
    end
  end

  def edit
    set_title("Editing Geotag #{@geotag.id}")

    respond_to do |format|
      format.html
      format.xml { render :xml => @geotag }
      format.json { render :json => @geotag }
    end
  end

  def update
    @geotag.attributes = params[:geotag]

    if @geotag.save
      redirect_to geotags_path
    end
  end


  private

  def load_objects
    @geotag = Geotag.find_by_id(params[:id])
    if params[:photo_id] && params[:album_id]
      @geotag = Photo.find_by_permalink_and_album_id(params[:photo_id], Album.find_by_permalink(params[:album_id]).id).geotag
    end
    redirect_to geotags_path unless @geotag
  end
  
end
