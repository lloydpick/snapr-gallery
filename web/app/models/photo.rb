# == Schema Information
# Schema version: 20080729231414
#
# Table name: photos
#
#  id         :integer         not null, primary key
#  album_id   :integer
#  image_id   :integer
#  path       :string(255)
#  title      :string(255)
#  caption    :string(255)
#  is_visible :boolean         default(TRUE)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#  permalink  :string(200)
#  geotag_id  :integer
#

class Photo < ActiveRecord::Base
  
  has_one :image, :conditions => 'parent_id is null'
  belongs_to :geotag
  belongs_to :album
  acts_as_list :scope => :album
  has_permalink :title, :scope => :album_id

  validates_presence_of :album_id
  validates_presence_of :image_id
  validates_presence_of :title
  validates_numericality_of :album_id, :only_integer => true, :allow_nil => false
  validates_numericality_of :image_id, :only_integer => true, :allow_nil => false
  
  def to_param
    permalink
  end
  
end
