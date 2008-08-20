class Geotag < ActiveRecord::Base
  
  has_many :photos, :order => :position
  
end
