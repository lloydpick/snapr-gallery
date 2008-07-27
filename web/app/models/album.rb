class Album < ActiveRecord::Base
  
  has_many :photos
  has_permalink :title
  
  acts_as_ordered :order => 'position'

  def to_param
    permalink
  end
  
end
