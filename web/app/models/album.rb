class Album < ActiveRecord::Base
  
  has_many :photos
  has_permalink :title 

  def to_param
    permalink
  end
  
end
