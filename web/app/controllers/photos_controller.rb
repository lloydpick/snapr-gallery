class PhotosController < ApplicationController
  
  def show
    @album = Album.find_by_permalink(params[:permalink])
    if not @album
      raise "ZOMG NO ALBUM FOUND!"
    end
    @photo = Photo.find_by_permalink(params[:photolink])
    if not @photo
      raise "ZOMG NO PHOTO FOUND!"
    else
      if @photo.album.id == @album.id
        @image = Image.find_by_id(@photo.image_id)
        @exif = Magick::Image.read(@image.full_filename).first
        if @exif.get_exif_by_entry.size > 0
          @show_exif = true
        else
          @show_exif = false
        end
        @title = "Photo - " + @photo.title
      else
        raise "PHOTO NOT PART OF ALBUM"
      end
    end
  end
  
  def show_full
    @go_wide = true
    @album = Album.find_by_permalink(params[:permalink])
    if not @album
      raise "ZOMG NO ALBUM FOUND!"
    end
    @photo = Photo.find_by_permalink(params[:photolink])
    if not @photo
      raise "ZOMG NO PHOTO FOUND!"
    else
      if @photo.album.id == @album.id
        @image = Image.find_by_id(@photo.image_id)
        @title = "Full Photo - " + @photo.title
      else
        raise "PHOTO NOT PART OF ALBUM"
      end
    end
  end
  
end
