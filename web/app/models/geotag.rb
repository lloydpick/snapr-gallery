# == Schema Information
# Schema version: 20080729231414
#
# Table name: geotags
#
#  id          :integer         not null, primary key
#  latitude    :float
#  longitude   :float
#  zoom        :integer
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Geotag < ActiveRecord::Base
  
  has_many :photos, :order => :position

  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :zoom
  validates_presence_of :description

  default_scope :order => "description ASC"
  
end
