class HomeController < ApplicationController
  
  def home
    @photostream = true
    @sitestream = true
    
    @albums = Album.find(:all, :order => "updated_at DESC", :limit => 4)
    @photos = Photo.find(:all, :order => "updated_at DESC", :limit => 4)
  end

  def userhome
  end
  
end