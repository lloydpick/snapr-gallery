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
      else
        raise "PHOTO NOT PART OF ALBUM"
      end
    end
  end
  
end
