class ImagesController < ApplicationController
      
  def new
    @image = Image.new
    @album = Album.find_by_permalink(params[:permalink])
    p = Photo.find(:all, :conditions => { :album_id => @album.id })
    if p.size == 0
      @next = 1
    else
      @next = p.last.position+1
    end
  end
  
  def create
    sleep(5)
    @album = Album.find_by_permalink(params[:permalink])
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = 'Image was successfully created.'
      @photo = Photo.new
      @photo.album_id = @album.id
      @photo.image_id = @image.id
      @photo.title = params[:photo][:title]
      if @photo.title == ""
        @split = @image.filename.split('.')
        @photo.title = @split[0]
      end
      @photo.caption = params[:photo][:caption]
      @photo.is_visible = params[:photo][:is_visible]
      @photo.position = params[:photo][:position]
      p = Photo.find(:all, :conditions => { :album_id => @album.id })
      # Does it pass all validation?
      if @photo.save
        if @photo.position == ""
          if p.size == 0
            @photo.position = 1
            @photo.save
          else
            @photo.position = p.last.position+1
            @photo.save
          end
        else
          if p.size == 0
            @photo.position = 1
            @photo.save
          else
            if @photo.position > p.last.position+2
              #if the photos position is greater than my last photo in my list
              #change it to fit right after the last one, for example
              #if my last item has a position of 6, let's set this new one to 
              #a position of 7
              @photo.position = p.last.position+1
              @photo.save
            end
          end
        end
        @album.updated_at = Time.now
        @album.save!
        @log = Log.new
        @log.user = current_user
        @log.item = "photo"
        @log.event = "add_photo"
        @log.identifier = @photo.id
        @log.save!
        # Save successful, redirect to album page
        redirect_to :controller => "albums", :action => "show", :permalink => @album.permalink
      else
        # Show the error messages
        @album.valid?
      end
      #redirect_to images_url(@image)
    else
      render :action => :new
    end
  end
  
end