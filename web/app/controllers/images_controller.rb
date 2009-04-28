 class ImagesController < ApplicationController

  before_filter :login_required, :only => ["new"]
  before_filter :load_objects

  def show
    set_title("Showing full size")
    @go_wide = true

    respond_to do |format|
      format.html
      format.xml { render :xml => @image }
      format.json { render :json => @image }
    end
  end
     
  def new
    @title = "Upload Image"
    @image = Image.new
    p = Photo.find(:all, :conditions => { :album_id => @album.id })
    if p.size == 0
      @next = 1
    else
      @next = p.last.position+1
    end

    respond_to do |format|
      format.html
      format.xml { render :xml => @image }
      format.json { render :json => @image }
    end
  end

  def create
    @image = Image.new :swf_uploaded_data => params[:Filedata]
    @image.save!

    @photo = Photo.new
    @photo.album_id = @album.id
    @photo.image_id = @image.id
    @split = @image.filename.split('.')
    @photo.title = @split[0]
    @photo.is_visible = true

    p = Photo.find(:all, :conditions => { :album_id => @album.id })
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
    end

    render :text => @image.public_filename(:thumbnail)
  end
  

  private

  def load_objects
    @album = Album.find_by_permalink(params[:album_id])
    @photo = Photo.find_by_permalink_and_album_id(params[:photo_id], @album.id)
    @image = Image.find_by_id(params[:id])
  end
  
end
