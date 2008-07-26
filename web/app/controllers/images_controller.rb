class ImagesController < ApplicationController
      
  def new
    @image = Image.new
  end
  
  def create
    sleep(5)
    @image = Image.new(params[:image])
    if @image.save
      flash[:notice] = 'Image was successfully created.'
      #redirect_to images_url(@image)     
    else
      render :action => :new
    end
  end
  
end
