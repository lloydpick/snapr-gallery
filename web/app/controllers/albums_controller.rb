class AlbumsController < ApplicationController

  in_place_edit_for :album, :description

  before_filter :login_required, :only => ["new", "create", "edit", "update", "set_album_description"]
  before_filter :load_objects, :only => ["show", "edit", "update"]

  # Public Actions
  
  def index
    set_title("Album List")
    @albums = Album.root.visible

    respond_to do |format|
      format.html
      format.xml { render :xml => @albums }
      format.json { render :json => @albums }
    end
  end
  
  def show
    set_title("Album - " + @album.title)

    respond_to do |format|
      format.html
      format.xml { render :xml => @album }
      format.json { render :json => @album }
    end
  end

  # Private Actions

  def edit
    set_title("Edit Album - " + @album.title)
   
    respond_to do |format|
      format.html
    end
  end

  def update
    @album.attributes = params[:album]

    if @album.save
      redirect_to albums_path
    end
  end

  def new
    set_title("Create Album")
    @album = Album.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @album = Album.new(params[:album])

    # Does it pass all validation?
    if @album.save
      redirect_to album_path(@album)
    else
      @album.valid?
    end
  end

  private

  def load_objects
    @album = Album.find_by_permalink(params[:id])
    if not @album
      redirect_to albums_path
    end
  end
  
end
