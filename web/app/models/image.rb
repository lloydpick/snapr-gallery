require "image_voodoo"
require "exifr"

class Image < ActiveRecord::Base

  belongs_to :photo
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 5.megabytes,
                 :keep_profile => true,
                 :thumbnails => { 
                                  :square => [75,75],
                                  :thumbnail => '100x75',
                                  :small => '240x180>',
                                  :medium => '500x375>',
                                  :large => '1024x768>'
                                }

  validates_as_attachment
  @@exif_date_format = '%Y:%m:%d %H:%M:%S'
  cattr_accessor :exif_date_format
  attr_accessor :skip_resize
  
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
  
  protected

  # Override image resizing method
  def resize_imagesdsds(img, size, compress=false)
    # resize_image take size in a number of formats, we just want
    # Strings in the form of "crop: WxH"
    if (size.is_a?(String) && size =~ /^crop: (\d*)x(\d*)/i) ||
        (size.is_a?(Array) && size.first.is_a?(String) &&
          size.first =~ /^crop: (\d*)x(\d*)/i)
      img.crop_resized!($1.to_i, $2.to_i)
      bw = img.columns
      bh = img.rows
      base = bw > bh ? bw : bh;
      if (base <= 800)
        sigma = 1.9
      elsif (base <= 1600)
        sigma = 2.85
      else
        sigma = 3.8
      end
      #img = img.sharpen(1, sigma)
      # We need to save the resized image in the same way the
      # orignal does.
      self.temp_path = write_to_temp_file(img.to_blob {self.quality = 100})
    elsif (size.is_a?(String) && size =~ /^sharp: (\d*)x(\d*)>/i) ||
        (size.is_a?(Array) && size.first.is_a?(String) &&
          size.first =~ /^sharp: (\d*)x(\d*)>/i)
      bw = img.columns
      bh = img.rows
      base = bw > bh ? bw : bh;
      if (base <= 800)
        sigma = 1.9
      elsif (base <= 1600)
        sigma = 2.85
      else
        sigma = 3.8
      end
      #img = img.sharpen(1, sigma)
      super
    else
      super # Otherwise let attachment_fu handle it
    end
  end

  
end
