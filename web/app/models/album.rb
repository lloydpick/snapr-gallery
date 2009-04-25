# == Schema Information
# Schema version: 20090425105913
#
# Table name: albums
#
#  id          :integer         not null, primary key
#  parent_id   :integer         default(0)
#  title       :string(255)
#  description :string(255)
#  is_visible  :boolean         default(TRUE)
#  created_at  :datetime
#  updated_at  :datetime
#  permalink   :string(200)
#

class Album < ActiveRecord::Base

  attr_accessor :current_user
  has_many :photos, :order => :position
  has_permalink :title
  acts_as_tree :order => "title"

  validates_presence_of :title
  validates_presence_of :description

  default_scope :order => "title ASC"
  named_scope :root, :conditions => { :parent_id => 0 }
  named_scope :visible, :conditions => { :is_visible => true }

  before_create :setup_permalink

  def setup_permalink
    if self.parent_id != 0
      self.permalink = "#{parent.permalink}-#{self.permalink}"
    end
  end

  def first_image(album = nil)
    look_from = self
    if album
      look_from = album
    end
    @image = nil
    
    if look_from.photos.first

      @image = Image.find_by_id(look_from.photos.first.image_id)

    else

      look_from.children.each do |child|
        if child.photos.size > 0
          @image = Image.find_by_id(child.photos.first.image_id)
          break
        end
      end

      if @image == nil
        look_from.children.each do |child|
          @image = first_image(child)
          if @image != nil
            break
          end
        end
      end
      
      @image
    end
  end

  def to_param
    permalink
  end
  
end
