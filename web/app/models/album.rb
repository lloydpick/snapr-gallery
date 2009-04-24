# == Schema Information
# Schema version: 20090423150120
#
# Table name: albums
#
#  id          :integer         not null, primary key
#  parent_id   :integer         default(0)
#  title       :string(255)
#  description :string(255)
#  position    :integer
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

  default_scope :order => "title ASC"
  named_scope :root, :conditions => { :parent_id => 0 }
  named_scope :visible, :conditions => { :is_visible => true }

  before_save :setup_permalink
  after_create :create_audit
  after_update :edit_audit

  def setup_permalink
    if self.parent_id != 0
      self.permalink = "#{parent.permalink}-#{self.permalink}"
    end
  end

  def create_audit
    Log.create_entry(current_user, "album", "add_album", self.id)
  end

  def edit_audit
    Log.create_entry(current_user, "album", "edit_album", self.id)
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
