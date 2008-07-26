class Image < ActiveRecord::Base

  belongs_to :photo
  
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 5.megabytes,
                 :resize_to => '1024x768>',
                 :thumbnails => { 
                                  :square => 'c75x75',
                                  :thumbnail => 'c100x75',
                                  :small => 's240x180>',
                                  :medium => '500x375>',
                                }

  validates_as_attachment
  
  
  protected

  # Override image resizing method
  def resize_imagesdsds(img, size, compress=false)
    # resize_image take size in a number of formats, we just want
    # Strings in the form of "crop: WxH"
    if (size.is_a?(String) && size =~ /^crop: (\d*)x(\d*)/i) ||
        (size.is_a?(Array) && size.first.is_a?(String) &&
          size.first =~ /^crop: (\d*)x(\d*)/i)
      img.crop_resized!($1.to_i, $2.to_i)
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
      img = img.sharpen(1, sigma)
      super
    else
      super # Otherwise let attachment_fu handle it
    end
  end

  
end
