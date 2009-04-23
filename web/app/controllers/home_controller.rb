class HomeController < ApplicationController
  
  def index
    @photostream = true
    @sitestream = true
    @title = "Home"
    
    @albums = Album.find(:all, :order => "updated_at DESC", :limit => 4)
    @photos = Photo.find(:all, :order => "updated_at DESC", :limit => 4)
  end
  
end