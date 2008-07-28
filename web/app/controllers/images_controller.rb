class ImagesController < ApplicationController

  before_filter :login_required, :only => ["new", "create"]
     
  def new
    @title = "Upload Image"
    @image = Image.new
    @album = Album.find_by_permalink(params[:permalink])
    p = Photo.find(:all, :conditions => { :album_id => @album.id })
    if p.size == 0
      @next = 1
    else
      @next = p.last.position+1
    end
  end
  
  def swfupload
    if RUBY_PLATFORM =~ /mswin/i
      sleep(5)
    end
    # swfupload action set in routes.rb
    @album = Album.find_by_permalink(params[:permalink])
    @image = Image.new :uploaded_data => params[:Filedata]
    if @image.save
      @photo = Photo.new
      @photo.album_id = @album.id
      @photo.image_id = @image.id
      @split = @image.filename.split('.')
      @photo.title = @split[0]
      @photo.is_visible = true
      p = Photo.find(:all, :conditions => { :album_id => @album.id })
      # Does it pass all validation?
      if @photo.save
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
        @album.updated_at = Time.now
        @album.save!
        @log = Log.new
        @log.user_id = params[:id]
        @log.item = "photo"
        @log.event = "add_photo"
        @log.identifier = @photo.id
        @log.save!
      end
      # This returns the thumbnail url for handlers.js to use to display the thumbnail
      render :text => @image.public_filename(:square)
    end
  rescue
    render :text => "Error"
  end
  
  def create
    if RUBY_PLATFORM =~ /mswin/i
      sleep(5)
    end
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