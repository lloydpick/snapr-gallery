class Photo < ActiveRecord::Base
  
  has_one :image, :conditions => 'parent_id is null'
  belongs_to :album
  
  acts_as_ordered :order => 'position'
  has_permalink :title 
  
  def to_param
    permalink
  end
  
end
