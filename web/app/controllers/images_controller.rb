class ImagesController < ApplicationController
      
  def new
    @image = Image.new
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
      # Does it pass all validation?
      if @photo.save
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