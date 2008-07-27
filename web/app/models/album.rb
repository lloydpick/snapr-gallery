class Album < ActiveRecord::Base
  
  has_many :photos, :order => :position
  has_permalink :title
  acts_as_tree :order => "title" 
  acts_as_list

  def to_param
    permalink
  end
  
end
