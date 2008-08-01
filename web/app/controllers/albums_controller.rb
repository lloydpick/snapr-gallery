class AlbumsController < ApplicationController
  
  before_filter :login_required, :only => ["new", "edit"]
  
  def new
    @title = "Create Album"
    # Post Request
    if request.post?
      # Create a new user
      @album = Album.new(params[:album])
      a = Album.find(:all)
      # Does it pass all validation?
      if @album.save
        
        if @album.position == ""
          if a.size == 0
            @album.position = 1
            @album.save
          else
            @album.position = a.last.position+1
            @album.save
          end
        else
          if a.size == 0
            @album.position = 1
            @album.save
          else
            if @album.position > a.last.position+2
              #if the photos position is greater than my last photo in my list
              #change it to fit right after the last one, for example
              #if my last item has a position of 6, let's set this new one to 
              #a position of 7
              @album.position = a.last.position+1
              @album.save
            end
          end
        end
        
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
    else
      a = Album.find(:all)
      if a.size == 0
        @next = 1
      else
        @next = a.last.position+1
      end
      @albums = Album.find(:all, :conditions => { :is_visible => true, :parent_id => nil }, :order => "position ASC")
    end
  end
  
  def show
    @album = Album.find_by_permalink(params[:permalink])
    if not @album
      raise "ZOMG NO ALBUM FOUND!"
    end
    @title = "Album - " + @album.title
  end
  
  def list
    @title = "Album List"
    @albums = Album.find(:all, :conditions => { :is_visible => true, :parent_id => nil }, :order => "position ASC, title ASC")
  end
  
  def list_text
    @title = "Album Text List"
    @albums = Album.find(:all, :conditions => { :is_visible => true, :parent_id => nil }, :order => "position ASC")
  end
  
  def edit
    @title = "Album Edit"
   
    if request.post?
      @album = Album.find_by_id(params[:album][:id])
      @album.attributes = params[:album]
  
      if @album.save
        @log = Log.new
        @log.user = current_user
        @log.item = "album"
        @log.event = "edit_album"
        @log.identifier = @album.id
        @log.save!
        redirect_to :action => "list"
      end
    else
      @album = Album.find_by_permalink(params[:permalink])
    end
    
  end
  
end
