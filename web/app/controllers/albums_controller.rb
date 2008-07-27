class AlbumsController < ApplicationController
  
  def new
    # Post Request
    if request.post?
      # Create a new user
      @album = Album.new(params[:album])
      # Does it pass all validation?
      if @album.save
        # Save successful, redirect to album page
        @log = Log.new
        @log.user = current_user
        @log.item = "album"
        @log.event = "add_album"
        @log.identifier = @album.id
        @log.save!
        redirect_to :action => "show", :permalink => @album.permalink
      else
        # Show the error messages
        @album.valid?
      end
    end
  end
  
  def show
    @album = Album.find_by_permalink(params[:permalink])
    if not @album
      raise "ZOMG NO ALBUM FOUND!"
    end
  end
  
  def list
    @albums = Album.find(:all, :conditions => { :is_visible => true }, :order => "position ASC, title ASC")
  end
  
end
