require "exifr"
require 'mime/types'

class Image < ActiveRecord::Base

  belongs_to :photo
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 5.megabytes,
                 :keep_profile => true,
                 :thumbnails => { 
                                  :square => 'c75x75',
                                  :thumbnail => 'c100x75',
                                  :small => 's240x180>',
                                  :medium => 's500x375>',
                                  :large => '1024x768>'
                                }


  validates_as_attachment
  @@exif_date_format = '%Y:%m:%d %H:%M:%S'
  cattr_accessor :exif_date_format

  # Map file extensions to mime types.
  # Thanks to bug in Flash 8 the content type is always set to application/octet-stream.
  # From: http://blog.airbladesoftware.com/2007/8/8/uploading-files-with-swfupload
  def swf_uploaded_data=(data)
    data.content_type = MIME::Types.type_for(data.original_filename)
    self.uploaded_data = data
  end
  
  def date_taken
    date = EXIFR::JPEG.new(full_filename).date_time
    return unless date
    date
  end

  def model
    model = EXIFR::JPEG.new(full_filename).model
    return unless model
    model
  end
  
  def flash
    flash = EXIFR::JPEG.new(full_filename).flash
    case flash.to_i
      when 0
        out = "Flash did not fire"
      when 1
        out = "Flash fired"
      when 5
        out = "Strobe return light not detected"
      when 7
        out = "Strobe return light detected"
      when 9
        out = "Flash fired, compulsory flash mode"
      when 13
        out = "Flash fired, compulsory flash mode, return light not detected"
      when 15
        out = "Flash fired, compulsory flash mode, return light detected"
      when 16
        out = "Flash did not fire, compulsory flash mode"
      when 24
        out = "Flash did not fire, auto mode"
      when 25
        out = "Flash fired, auto mode"
      when 29
        out = "Flash fired, auto mode, return light not detected"
      when 31
        out = "Flash fired, auto mode, return light detected"
      when 32
        out = "No flash function"
      when 65
        out = "Flash fired, red-eye reduction mode"
      when 69
        out = "Flash fired, red-eye reduction mode, return light not detected"
      when 71
        out = "Flash fired, red-eye reduction mode, return light detected"
      when 73
        out = "Flash fired, compulsory flash mode, red-eye reduction mode"
      when 77
        out = "Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected"
      when 79
        out = "Flash fired, compulsory flash mode, red-eye reduction mode, return light detected"
      when 89
        out = "Flash fired, auto mode, red-eye reduction mode"
      when 93
        out = "Flash fired, auto mode, return light not detected, red-eye reduction mode"
      when 95
        out = "Flash fired, auto mode, return light detected, red-eye reduction mode"
    end
    if out.length > 0
      return out
    else
      return false
    end
  end
  
  def make
    make = EXIFR::JPEG.new(full_filename).make
    return unless make
    make
  end

  def gps
    lat = EXIFR::JPEG.new(full_filename).gps_latitude
    lat_ref = EXIFR::JPEG.new(full_filename).gps_latitude_ref
    long = EXIFR::JPEG.new(full_filename).gps_longitude
    long_ref = EXIFR::JPEG.new(full_filename).gps_longitude_ref

    lat = lat[0].to_f + (lat[1].to_f / 60) + (lat[2].to_f / 3600)
    long = long[0].to_f + (long[1].to_f / 60) + (long[2].to_f / 3600)

    lat = lat * -1 if lat_ref == "S"      # (N is +, S is -)
    long = long * -1 if long_ref == "W"   # (W is -, E is +)

    gps = [lat, long]
    return unless gps
    gps
  end
   
end
