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
  
  def location
    
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
        @title = "Photo Location - " + @photo.title
        if @photo.geotag != nil
          @map = GMap.new("map_div")
          @map.control_init(:large_map => true,:map_type => true)
          @map.set_map_type_init(GMapType::G_HYBRID_MAP);
          @map.center_zoom_init([@photo.geotag.latitude,@photo.geotag.longitude],@photo.geotag.zoom)
          @map.overlay_init(GMarker.new([@photo.geotag.latitude,@photo.geotag.longitude], :title => "Photo Location", :info_window => @photo.caption))
        else
          redirect_to :action => "show", :permalink => @photo.album.permalink, :photolink => @photo.permalink 
        end
      else
        raise "PHOTO NOT PART OF ALBUM"
      end
    end
  end
end
