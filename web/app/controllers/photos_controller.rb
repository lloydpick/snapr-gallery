require "exifr"

class PhotosController < ApplicationController

  before_filter :load_object

  def show
    set_title("Photo - " + @photo.title)

    @image = Image.find_by_id(@photo.image_id)
    @show_exif = false
    @show_exif = true if EXIFR::JPEG.new(@image.full_filename)

    respond_to do |format|
      format.html
      format.xml { render :xml => @image }
      format.json { render :json => @image }
    end
  end
  
  def edit
    set_title("Edit Photo - " + @photo.title)

    respond_to do |format|
      format.html
    end
  end

  def update
    @photo.attributes = params[:photo]

    if @photo.save
      redirect_to album_photo_path(@photo.album, @photo)
    end
  end


  private

  def load_object
    @photo = Photo.find_by_permalink(params[:id])
    @album = Album.find_by_permalink(params[:album_id])
    redirect_to @album unless @photo
  end
  
end
